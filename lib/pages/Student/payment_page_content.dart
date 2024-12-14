import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/models/paymentModel.dart';
import 'package:tutornest/pages/Student/active_payment_page_content.dart';
import 'package:uuid/uuid.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPlan = '';
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _mpinController = TextEditingController();
  bool isProcessing = false;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void dispose() {
    _numberController.dispose();
    _mpinController.dispose();
    super.dispose();
  }

  Future<void> _processPayment(BuildContext context, String plan, double amount) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isProcessing = true);
    final studentid = await secureStorage.read(key: 'userId');

    try {
      // Simulate payment processing delay
      await Future.delayed(Duration(seconds: 2));

      // Show confirmation dialog
      bool? confirmed = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Payment'),
            content: Text('Are you sure you want to proceed with the payment of Rs. ${amount.toStringAsFixed(2)}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Confirm'),
              ),
            ],
          );
        },
      );

      if (confirmed == true) {
        final paymentRef = FirebaseFirestore.instance.collection('payments').doc();

        final payment = PaymentModel(
          paymentId: paymentRef.id,
          studentId: studentid ?? '',
          amount: amount,
          isPaid: true,
          plan: plan,
          dueDate: Timestamp.fromDate(
            DateTime.now().add(plan == 'Monthly Plan' ? Duration(days: 30) : Duration(days: 365)),
          ),
        );

        await FirebaseFirestore.instance
            .collection('payments')
            .doc()
            .set(payment.toFirestore());

        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Payment Successful'),
                content: Text('Your payment has been processed successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ActiveSubscriptionPage()));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Payment', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your plan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            PaymentOption(
              title: 'Monthly Plan',
              description: 'Access for one month',
              price: 'Rs. 5000',
              onTap: () => _showPaymentForm(context, 'Monthly Plan', 5000),
            ),
            PaymentOption(
              title: 'Yearly Plan',
              description: 'Access for one year',
              price: 'Rs. 30000',
              onTap: () => _showPaymentForm(context, 'Yearly Plan', 30000),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPaymentForm(BuildContext context, String plan, double amount) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _mpinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'MPIN',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter MPIN';
                  }
                  if (value.length != 4) {
                    return 'MPIN must be 4 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isProcessing
                    ? null
                    : () => _processPayment(context, plan, amount),
                child: isProcessing
                    ? CircularProgressIndicator()
                    : Text('Pay Rs. ${amount.toStringAsFixed(2)}'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final VoidCallback onTap;

  PaymentOption({
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18)),
        subtitle: Text(description),
        trailing: Text(price, style: TextStyle(fontSize: 16, color: Colors.green)),
        onTap: onTap,
      ),
    );
  }
}