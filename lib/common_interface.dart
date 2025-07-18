import 'package:flutter/material.dart';

class CommonLoginPage extends StatefulWidget {
  const CommonLoginPage({super.key});

  @override
  State<CommonLoginPage> createState() => _CommonLoginPageState();
}

class _CommonLoginPageState extends State<CommonLoginPage> 
  bool isStudentSelected = false;
  bool isAdminSelected = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool textVisible = true;

  void resetForm() {
    idController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common Login Interface', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Login As',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 20),

            // Student & Admin Selection Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Student Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isStudentSelected = true;
                      isAdminSelected = false;
                      resetForm();
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isStudentSelected ? Colors.purple : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.school, size: 36, color: isStudentSelected ? Colors.white : Colors.black),
                        const SizedBox(height: 5),
                        Text(
                          'Student',
                          style: TextStyle(
                            color: isStudentSelected ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Admin Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAdminSelected = true;
                      isStudentSelected = false;
                      resetForm();
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isAdminSelected ? Colors.purple : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.admin_panel_settings, size: 36, color: isAdminSelected ? Colors.white : Colors.black),
                        const SizedBox(height: 5),
                        Text(
                          'Admin',
                          style: TextStyle(
                            color: isAdminSelected ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Login Form
            if (isStudentSelected || isAdminSelected)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      isStudentSelected ? 'Student Login' : 'Admin Login',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                    const SizedBox(height: 15),

                    // ID Input Field
                    TextFormField(
                      controller: idController,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      decoration: InputDecoration(
                        labelText: isStudentSelected ? 'Student Roll No' : 'Admin ID',
                        prefixIcon: Icon(Icons.person, color: Colors.purple),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter ${isStudentSelected ? 'Student Roll No' : 'Admin ID'}";
                        } else if (value.length != 12) {
                          return "${isStudentSelected ? 'Student Roll No' : 'Admin ID'} must be exactly 12 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password Input Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: textVisible,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.purple),
                        suffixIcon: IconButton(
                          icon: Icon(
                            textVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              textVisible = !textVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        } else if (value.length != 12) {
                          return "Password must be exactly 12 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${isStudentSelected ? 'Student' : 'Admin'} Login Successful!'),
                              backgroundColor: Colors.purple,
                            ),
                          );
                          // Add redirection logic here based on role.
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
