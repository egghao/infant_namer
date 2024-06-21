import 'package:flutter/material.dart';
import 'dart:async';

class BabyNamingServicePage extends StatefulWidget {
  const BabyNamingServicePage({Key? key}) : super(key: key);

  @override
  _BabyNamingServicePageState createState() => _BabyNamingServicePageState();
}

class _BabyNamingServicePageState extends State<BabyNamingServicePage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _gender = '男';
  DateTime? _birthday;
  String _familyName = '';
  List<String> _suggestions = [];
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _generateNames() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
        _suggestions = [];
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock response
      final mockNames = {
        '男': ['宇轩', '浩然', '子墨'],
        '女': ['梓晴', '雨欣', '芷若'],
      };

      setState(() {
        _suggestions = mockNames[_gender]!;
        _isLoading = false;
      });

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF0F4FF), Color(0xFFFFE8E8)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.red, Colors.orange],
                          ).createShader(bounds),
                          child: const Text(
                            'AI命名大師',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                value: _gender,
                                decoration: InputDecoration(
                                  labelText: '性别',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                items: const [
                                  DropdownMenuItem(value: '男', child: Text('男孩')),
                                  DropdownMenuItem(value: '女', child: Text('女孩')),
                                ],
                                onChanged: (value) => setState(() => _gender = value!),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: '出生日期',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (date != null) {
                                    setState(() => _birthday = date);
                                  }
                                },
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _birthday != null
                                      ? '${_birthday!.year}-${_birthday!.month.toString().padLeft(2, '0')}-${_birthday!.day.toString().padLeft(2, '0')}'
                                      : '',
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: '姓氏',
                                  hintText: '例如：張、王、李',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onSaved: (value) => _familyName = value ?? '',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '請輸入姓氏';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: _generateNames,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text('獲取名字建議', style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (_isLoading)
                          const CircularProgressIndicator()
                        else if (_suggestions.isNotEmpty)
                          Column(
                            children: [
                              const Text('名字建議：', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),
                              ...List.generate(_suggestions.length, (index) {
                                return FadeTransition(
                                  opacity: _fadeInAnimation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.5),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                        index * 0.2,
                                        (index + 1) * 0.2,
                                        curve: Curves.easeOut,
                                      ),
                                    )),
                                    child: Card(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: ListTile(
                                        title: Text(
                                          '$_familyName${_suggestions[index]}',
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: const Text('寓意：充满希望和活力的名字'),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 20),
                              Text(
                                '基於$_gender孩，出生日期：${_birthday != null ? '${_birthday!.year}-${_birthday!.month}-${_birthday!.day}' : '未指定'}',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '注意：这些只是建議。',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}