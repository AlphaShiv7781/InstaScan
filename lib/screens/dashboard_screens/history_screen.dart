import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instascan/services/pdf_services/pdf_retrieval.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10.0 , 20,10,0),
          child: Text('History of Assessments'),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('history')
            .orderBy('timestamp', descending: true) // Order by latest first
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No History Found"));
          }

          var historyDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: historyDocs.length,
            itemBuilder: (context, index) {
              var doc = historyDocs[index];
              var data = doc.data() as Map<String, dynamic>;

              // Extract document ID
              String docId = doc.id;

              // Convert timestamp to readable format
              Timestamp? timestamp = data['timestamp'];
              String formattedDate = timestamp != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                  timestamp.millisecondsSinceEpoch)
                  .toString()
                  : "No Date";

              String patientName = data['patientName'] ?? 'No Name';
              String gender = data['gender']?? 'No detail';
              String pdfUrl = data['url'];

              return Padding(
                padding: const EdgeInsets.fromLTRB(20,20,20, 0),
                child: InkWell(
                  onTap: (){
                     openPDF(pdfUrl);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color(0xFF7EC9D4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black54),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                                 'Skin Cancer Assessment',
                                 style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold
                                 )
                             ),
                             SizedBox(height: 5),
                             Text(patientName , style: TextStyle(
                                 fontSize: 12,
                                 fontWeight: FontWeight.w700
                             ),
                             ),
                             Text(gender),
                             Text(formattedDate),
                             Text("Doc ID: $docId", style: TextStyle(fontSize: 12, color: Colors.black54)),
                           ],
                         ),
                         Spacer(),
                         Image(image: AssetImage('assets/images/skincancer.png'),),
                       ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

