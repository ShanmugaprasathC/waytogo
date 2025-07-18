import 'package:flutter/material.dart';

class CommonLoginPage extends StatefulWidget {
  const CommonLoginPage({super.key});

  @override
  State<CommonLoginPage> createState() => _CommonLoginPageState();
}

class _CommonLoginPageState extends State<CommonLoginPage> {
  bool isStudentSelected = false;
  bool isAdminSelected = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool textVisible = true;

  void resetForm() {
    idController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Color violet = const Color(0xFF7E57C2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Canteen Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: violet,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Login As',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: violet,
              ),
            ),
            const SizedBox(height: 20),

            // Role Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleCard(
                  title: 'Student',
                  icon: Icons.school,
                  selected: isStudentSelected,
                  onTap: () {
                    setState(() {
                      isStudentSelected = true;
                      isAdminSelected = false;
                      resetForm();
                    });
                  },
                  color: violet,
                ),
                _buildRoleCard(
                  title: 'Admin',
                  icon: Icons.admin_panel_settings,
                  selected: isAdminSelected,
                  onTap: () {
                    setState(() {
                      isAdminSelected = true;
                      isStudentSelected = false;
                      resetForm();
                    });
                  },
                  color: violet,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Login Form
            if (isStudentSelected || isAdminSelected)
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      isStudentSelected ? 'Student Login' : 'Admin Login',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // ID Field
                    TextFormField(
                      controller: idController,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      decoration: _buildInputDecoration(
                        label: isStudentSelected ? 'Student Roll No' : 'Admin ID',
                        icon: Icons.person,
                        color: violet,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter ${isStudentSelected ? 'Roll No' : 'Admin ID'}";
                        } else if (value.length != 12) {
                          return "${isStudentSelected ? 'Roll No' : 'Admin ID'} must be 12 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: textVisible,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      decoration: _buildInputDecoration(
                        label: "Password",
                        icon: Icons.lock,
                        color: violet,
                        suffix: IconButton(
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        } else if (value.length != 12) {
                          return "Password must be 12 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${isStudentSelected ? 'Student' : 'Admin'} Login Successful!',
                              ),
                              backgroundColor: violet,
                            ),
                          );
                          // TODO: Navigate to dashboard
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: violet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
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

  // Widget: Role Card
  Widget _buildRoleCard({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color: selected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          boxShadow: selected
              ? [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: selected ? Colors.white : Colors.black87),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget: Input Decoration
  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    required Color color,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: color),
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
