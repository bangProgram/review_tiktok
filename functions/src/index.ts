import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const spawn = require("child-process-promise").spawn;

export const onVideoCreated = functions.firestore.document("videos/{videoId}").onCreate( async (snapshot, context) => {
    const videoData = snapshot.data();
    const videoId = `${snapshot.id}`;
    await spawn("ffmpeg",[
        "-i",
        videoData.fileURL,
        "-ss",
        "00:00:01.000",
        "-vframes",
        "1",
        "-vf",
        "scale=150:-1",
        `/tmp/${videoId}.jpg`
    ]);

    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${videoId}.jpg`,{
        destination : `thumbnails/${videoId}.jpg`
    }
    );
    await file.makePublic();
    const thumbnailURL = file.publicUrl();

    await snapshot.ref.update({"thumbnailURL" : thumbnailURL});

    const db = admin.firestore();
    await db.collection('users').doc(videoData.creatorUid).collection('videos').doc(videoId).create({"videoId":videoId,"thumbnailURL" : thumbnailURL});

});

export const onLikeVideo = functions.firestore.document('likes/{id}').onCreate(async (snapshot, context) => {
    const id = snapshot.id;
    const[videoId, _] = id.split('000');
    
    const db = admin.firestore();
    db.collection('videos').doc(videoId).update({likes:admin.firestore.FieldValue.increment(1)});

    const video = (await db.collection('videos').doc(videoId).get()).data();
    if(video){
        const creatorUid = video.creatorUid;
        const user = (await db.collection('users').doc(creatorUid).get()).data();
        if(user){
            const token = user.token;
            await admin.messaging().send({
                token:token,
                data:{
                    "screen":"chat",
                },
                notification:{
                    title:"cloud functions 에서 보내드립니다",
                    body:"내용은 없습니다 킥킥",
                }
            });
        }
    }

    
});

export const onDisLikeVideo = functions.firestore.document('likes/{id}').onDelete(async (snapshot, context) => {
    const id = snapshot.id;
    const[videoId, _] = id.split('000');
    
    const db = admin.firestore();
    db.collection('videos').doc(videoId).update({likes:admin.firestore.FieldValue.increment(-1)});
    
});

export const onLikeVideo_review = functions.firestore.document('videos/{videoId}').onUpdate(async (snapshot, context) =>{
    
    const befData = await snapshot.before.data();
    const aftData = await snapshot.after.data();

    const befLiker = befData.liker || [];
    const aftLiker = aftData.liker || [];

    if(befLiker.length < aftLiker.length){
        const db = admin.firestore();
        const message = admin.messaging();
        const receiveUid = aftData.creatorUid;
        const sendUid = aftLiker[aftLiker.length - 1];

        const receiver = (await db.collection('users').doc(receiveUid).get()).data();
        const sender = (await db.collection('users').doc(sendUid).get()).data();

        if(receiver && sender){
            const token = receiver.token;
            const msg = {
                token : token,
                data : {
                    "screen":"home"
                },
                notification : {
                    title : aftData.title,
                    body : `${sender.name} 님이 이 영상을 좋아합니다.`
                },
            }
            await message.send(msg);
        }
    }else{
        return;
    }

});