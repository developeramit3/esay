const functions = require("firebase-functions");

const admin = require('firebase-admin');
admin.initializeApp(functions.config().functions);

exports.orderTrigger = functions.firestore.document('notices/{noticesId}').onCreate

(
        async(snapshot , context )=>
        
        {
                var payload ={notification :{title:snapshot.data().title, body:snapshot.data().subtitle}
        ,data : {click_action : 'FLUTTER_NOTIFICATION_CLICK' }}
        const resp = await admin.messaging().sendToTopic('Admin',payload); 
        }
);

exports.orderTriggerDvies = functions.firestore.document('notices72/{notices72Id}').onCreate

(
        async(snapshot , context )=>        
        {
                var tokens =[];
                tokens.push(snapshot.data().token); 
                var payload ={notification :{title:snapshot.data().title, body:snapshot.data().subtitle}
        ,data : {click_action : 'FLUTTER_NOTIFICATION_CLICK' }}
        const resp = await admin.messaging().sendToDevice(tokens,payload); 
        }
);