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
    const Color primaryPurple = Color(0xFF7C4DFF);
    const Color bgBlack = Colors.black;
    const Color whiteText = Colors.white;

    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: primaryPurple,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Canteen Login',
          style: TextStyle(color: whiteText, fontWeight: FontWeight.bold),
        ),
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
                color: primaryPurple,
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
                  color: primaryPurple,
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
                  color: primaryPurple,
                ),
              ],
            ),
            const SizedBox(height: 30),

            if (isStudentSelected || isAdminSelected)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      isStudentSelected ? 'Student Login' : 'Admin Login',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: whiteText,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ID Field
                    if (isStudentSelected)
                      TextFormField(
                        controller: idController,
                        keyboardType: TextInputType.text,
                        maxLength: 7,
                        style: const TextStyle(color: whiteText),
                        decoration: _buildInputDecoration(
                          label: 'Student Roll No',
                          icon: Icons.person,
                          color: primaryPurple,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Roll No";
                          }
                          final pattern = RegExp(r'^22CSEC\d{2}$', caseSensitive: false);
                          if (!pattern.hasMatch(value)) {
                            return "Enter a valid Student ID (e.g., 22CSEC01)";
                          }
                          return null;
                        },
                      ),

                    if (isAdminSelected)
                      TextFormField(
                        controller: idController,
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        style: const TextStyle(color: whiteText),
                        decoration: _buildInputDecoration(
                          label: 'Admin ID',
                          icon: Icons.person,
                          color: primaryPurple,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Admin ID";
                          }
                          //final pattern = RegExp(r'^Admin@[A-Z][a-zA-Z0-9]{3}$');
                          // if (!pattern.hasMatch(value)) {
                          //   return "Admin ID must be like 'Admin@Xyz1'";
                          // }
                          return null;
                        },
                      ),

                    const SizedBox(height: 15),

                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: textVisible,
                      keyboardType: TextInputType.text,
                      maxLength: isStudentSelected ? 11 : 4,
                      style: const TextStyle(color: whiteText),
                      decoration: _buildInputDecoration(
                        label: "Password",
                        icon: Icons.lock,
                        color: primaryPurple,
                        suffix: IconButton(
                          icon: Icon(
                            textVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade300,
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
                        }
                        if (isStudentSelected && value.length != 11) {
                          return "Password must be 11 digits";
                        } else if (isAdminSelected && value.length != 4) {
                          return "Password must be 4 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${isStudentSelected ? 'Student' : 'Admin'} Login Successful!',
                              ),
                              backgroundColor: primaryPurple,
                            ),
                          );
                          // TODO: Navigate to admin or student dashboard
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
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
          color: selected ? color : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? color : Colors.grey.shade600),
          boxShadow: [
            BoxShadow(
              color: selected ? color.withOpacity(0.3) : Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    required Color color,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      prefixIcon: Icon(icon, color: color),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
