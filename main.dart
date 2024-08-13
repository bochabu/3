import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheets Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false, 
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> mainTabData = [];
  List<List<dynamic>> attendanceLogData = [];
  List<List<dynamic>> passwordTabData = [];

  @override
  void initState() {
    super.initState();
    fetchSheetData();
  }

  Future<void> fetchSheetData() async {
    final credentials = ServiceAccountCredentials.fromJson(r'''
    {
      "type": "service_account",
      "project_id": "fluted-reason-424618-j2",
      "private_key_id": "0577a7418ac6b1b0d9ec5b5bbb4fefc8d26b264d",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7PXOnmXKVyM5n\nbTdiNOuP+chb/1okyCyOV4a7FTBuMhU5f3yOGFPzbv+w3iV37+V6RpUMHvNEe2z8\nO/MPIwO+WEW4INjHZr/A4bgK6RBA39xYkiWB6Tfn6Alnc3vWA9udrxfNdVIBUTuG\niNOediQWh729lh1Y8mVDojkoIvDxfdPwYs4hI87mc3oYfNlRT/pMy+PGXdPC9DLI\no6oK7V+LzlG9VcfR9+/EmCRXsCTQ3KGRIrtrlPF/OF8DtMJ3uqL7gapML5uMTiBD\ns9CrJBd6OY8VyhLDS22Fm/QYM7NRoM3IFKtfFtNjZIBDP9nrObhVW7WH3S29E3fC\nGLg9wTxxAgMBAAECggEAAwXEdqXzJgu1ut2Neg5vLBs3AAweE0XLbHgC+LQoZR3t\ndA0G3E2wGYKiuzhiRx+RhxfZhlzmEvND6bjbn0Nl5zSj2eDeZWGj97lTeKO/+Vn9\nXVW50r4Kcdwe2BNoCI1lH7ZyVbf/trEQRcuhpdQRuohyBkRzfTqOFWQmRYVC4C7O\nVXspMmw3UE9poc8BUWAUtuxv9yf695Jzq2Bq8KBhUE5yV1XChh075n0FfNKnV03O\nbbDEPC9q7RqD96ohxy/tlzcp5jP/UYy7W7f8bIHVCDzWr5Kkaa6+8OIhMR1aRA/0\nmGg2c99B60f39Gyrtx1xDo8BCylJ0AYIlC0V7+vHHQKBgQD8bD8aEjADD/bg2Yp+\nY+yrA8fIzVD97UBN4bRPrXq4AcWr9kxhJ+OhuFybV8TU/rFUsSZPwuL4sDnuM5ix\nYKNYev9ggl6xJLvMT8DLAEY2P+n4SqqsJcjTHG7cLSe7GwDwnuwsPvMMK5P23wpC\n372SPX48BD5UZgaS2VJRpcl2UwKBgQC95LtHEvMutowAqdxzEMxS7hMzF4VHpFmg\nBwAmib/xDFu7fubhWNktYgq5rPMxZ/ffFr1QT4U6ENXBJ8/VFRCeINMQ6idWiNsj\nXfNXsVJ3A221w6efpOy/HtKKwHBx5ODIFdBaQmTPCnI0JrUpNHiKweHtNKeAicIr\nd/riHYehqwKBgBIRYXbpRFyDwQUZLSuc1WzsSVmbMKfsWoT4meJ2JWmUXuTPLWpq\n44VI4AASiTlBvcm1IGvnJD3ux0bAlLZll2uW6j6rNkHxwit+resZ6uypKIMoPQ0z\nayuJRnomFUj0Rt3yUi9cliMR33Z1QpPE1hnooueC2j9KSkAqpBTKDCCXAoGAC4PB\nL3AguuZq2udx7LBKE4VIOMLmXA/FN4T1J2EW+IDtVxM84NFIag4V5GhuXsKVLzvr\nwuDvjTPUImBNo/ghB9Wpts7cD81ArIZX6SthesIEdw8kLPQNPxGZZryAlQdx8fAQ\nsEhyYHObtTnbpmH+JTvYfU/CEHNKCOS/m9J6lP0CgYBuLryXvjSVXAhLJDAexNYo\nbOOPg/yO2EufAJ5wgiCfTpY/3Kv1FH4NrRyoB5vYmZOJpFJ7kEToGtXkJjw4R99c\nDCdetnvDUs7vKtBaNb/6nkjp9idx3hEZK8rNX6py4mF+uabRL4KsYVQYHhilZ5Lu\nD+lMMe2/kxd3g8LM7wJS9Q==\n-----END PRIVATE KEY-----\n",
      "client_email": "project1@fluted-reason-424618-j2.iam.gserviceaccount.com",
      "client_id": "112711183304679370302",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/project1%40fluted-reason-424618-j2.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
    ''');

    final scopes = [sheets.SheetsApi.spreadsheetsScope];
    final client = await clientViaServiceAccount(credentials, scopes);
    final sheetsApi = sheets.SheetsApi(client);

    const spreadsheetId = '1t50GI9vm1xLFnMy9qICKBnJvL3a8lIGlLQ93gvxMIFM';
    const mainTabRange = 'main tab!A1:F';
    const attendanceLogRange = 'attendance log!A1:E';
    const passwordTabRange = 'password tab!A1:A2';

    final mainTabResponse = await sheetsApi.spreadsheets.values.get(spreadsheetId, mainTabRange);
    final attendanceLogResponse = await sheetsApi.spreadsheets.values.get(spreadsheetId, attendanceLogRange);
    final passwordTabResponse = await sheetsApi.spreadsheets.values.get(spreadsheetId, passwordTabRange);

    setState(() {
      mainTabData = mainTabResponse.values ?? [];
      attendanceLogData = attendanceLogResponse.values ?? [];
      passwordTabData = passwordTabResponse.values ?? [];
    });
  }

  Future<void> _refreshData() async {
    await fetchSheetData();
  }

  List<DataRow> _buildRows(List<List<dynamic>> data) {
    int columnCount = data.isNotEmpty ? data[0].length : 0;
    return data.skip(1).map((row) {
      if (row.length < columnCount) {
        row.addAll(List.filled(columnCount - row.length, ''));
      }
      return DataRow(cells: row.map((cell) => DataCell(Text(cell.toString()))).toList());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Google Sheets Data',
            style: TextStyle(color: Colors.white), // Thay đổi màu chữ thành trắng
          ),
          backgroundColor: Colors.blue, // Thay đổi nền thành màu xanh
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white), // Thêm nút refresh
              onPressed: _refreshData,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Main Tab'),
              Tab(text: 'Attendance Log'),
              Tab(text: 'Password Tab'),
            ],
            labelColor: Colors.white, // Thay đổi màu chữ thành trắng
            indicatorColor: Colors.white, // Thay đổi màu indicator thành trắng
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(mainTabData),
            _buildTabContent(attendanceLogData),
            _buildTabContent(passwordTabData),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(List<List<dynamic>> data) {
    if (data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Thêm cuộn ngang
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: DataTable(
                columns: data[0]
                    .map((header) => DataColumn(label: Text(header.toString())))
                    .toList(),
                rows: _buildRows(data),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
