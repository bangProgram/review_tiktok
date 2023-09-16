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
