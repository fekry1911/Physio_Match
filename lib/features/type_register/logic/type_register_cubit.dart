import 'dart:io';

import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/type_register/logic/type_register_state.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../doctor/data/models/doctor_model.dart';
import '../data/rebo/register_repo.dart';

class TypeRegisterCubit extends Cubit<TypeRegisterState> {
  TypeRegisterCubit(this.registerRepository, this.auth)
    : super(StudentInitial());
  FirebaseAuth auth;

  RegisterRepository registerRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController specializationController = TextEditingController();


  int currentStep = 0;

  final formKeys = [
    GlobalKey<FormState>(), // Step 1
    GlobalKey<FormState>(), // Step 2
    GlobalKey<FormState>(), // Step 3
  ];
  String? selectedGender;
  bool isSelectedGender = false;

  void changeGender(String gender) {
    selectedGender = gender;
    print(selectedGender);
    isSelectedGender = true;
    emit(StudentGenderChanged());
  }

  Future<void> submitStudent() async {
    emit(StudentSubmitLoading());
    try {
      await registerRepository.registerDoctor(DoctorModel(
          fullName: nameController.text,
          university: universityController.text,
          phone: phoneController.text,
          gender: selectedGender,
          dateOfBirth: yearController.text,
          city: cityController.text,
          email: auth.currentUser!.email!,
          imageUrl:uploadedImageUrl!,
          tries: 3,
          resume: uploadedCvUrl ?? "",
          specialization: specializationController.text
        )
      );
      print(nameController.text);
      print(phoneController.text);
      print(selectedGender);
      print(yearController.text);
      print(cityController.text);
      print(auth.currentUser!.email!);
      print(uploadedImageUrl);
      print(uploadedCvUrl);
      print(specializationController.text);

      CacheHelper.putString(key: "type", value: "Doctor");
      CacheHelper.putBoolean(key: "submitted", value: true);
      emit(StudentSubmitted());
    } catch (e) {
      print(e.toString());
      emit(StudentSubmitFailed(error: e.toString()));
    }
  }


  void nextStep() {
    print(nameController.text);
    print(phoneController.text);
    print(selectedGender);
    print(yearController.text);
    print(cityController.text);
    print(auth.currentUser!.email!);
    print(uploadedImageUrl);
    print(uploadedCvUrl);
    print(specializationController.text);
    if (currentStep == 2) {
      submitStudent(); // آخر خطوة، نرسل البيانات
    } else {
      currentStep++;
      emit(StudentInitial());
    }
  }

  final picker = ImagePicker();
  String? uploadedImageUrl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  String UploadedPdf = "No file added";
  String? fileName;

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final originalFile = File(pickedFile.path);
    fileName = path.basename(pickedFile.path);
    print("$fileName 1111111111111111111111111111111111111111111111111111");


    try {
      print("$fileName 1111111111111111111111111111111111111111111111111111");
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        originalFile.absolute.path,
        quality: 70,
      );

      if (compressedBytes == null) {
        print('❌ فشل في ضغط الصورة');
        emit(UploadImageFail());
        return;
      }

      final sizeInMB = compressedBytes.lengthInBytes / (1024 * 1024);
      print('📏 حجم الصورة المضغوطة: ${sizeInMB.toStringAsFixed(2)} MB');

      if (sizeInMB > 50) {
        print('❌ الصورة لسه كبيرة (>50MB)');
        emit(UploadImageFail());
        return;
      }

      emit(UploadImageLoad());
      // ✅ الحصول على UID من Firebase Auth
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        print('❌ المستخدم غير مسجل دخول');
        emit(UploadImageFail());
        return;
      }

      // ✅ اسم ملف باستخدام uid
      final userFilePath = 'public/${uid}_profile.jpg';

      final storageRef = Supabase.instance.client.storage.from('images');
      await storageRef.uploadBinary(
        userFilePath,
        compressedBytes,
        fileOptions: FileOptions(upsert: true, contentType: 'image/jpeg'),
      );

      final publicUrl = storageRef.getPublicUrl(userFilePath);
      uploadedImageUrl = publicUrl;

      emit(UploadImageSucc());
    } catch (e) {
      print('❌ Error: $e');
      emit(UploadImageFail());
    }
  }
  String? uploadedCvUrl="";
  Future<void> pickAndUploadCV() async {
    try {
      final typeGroup = XTypeGroup(label: 'PDF', extensions: ['pdf']);
      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file == null) {
        print('🚫 لم يتم اختيار ملف');
        return;
      }

      final fileBytes = await file.readAsBytes();
      final fileName = file.name;

      final sizeInMB = fileBytes.lengthInBytes / (1024 * 1024);
      print('📏 حجم CV: ${sizeInMB.toStringAsFixed(2)} MB');

      if (sizeInMB > 50) {
        print('❌ الملف أكبر من الحد المسموح به (50MB)');
        return;
      }

      emit(UploadImageLoad());

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        print('❌ المستخدم غير مسجل دخول');
        return;
      }

      final userFilePath = '${uid}_cv.pdf'; // ✅ لا تضع "public/"
      final storageRef = Supabase.instance.client.storage.from('documents');

      await storageRef.uploadBinary(
        userFilePath,
        fileBytes,
        fileOptions: const FileOptions(
          upsert: true,
          contentType: 'application/pdf',
        ),
      );

      final publicUrl = storageRef.getPublicUrl(userFilePath);
      uploadedCvUrl=publicUrl;
      print('📄 تم رفع CV: $publicUrl');

      UploadedPdf = publicUrl;
      emit(UploadImageSucc());
    } catch (e) {
      print('❌ Error: $e');
      emit(UploadCVFail());
    }
  }

  setCurrentStep(int step) {
    currentStep = step;
    emit(SetCurrent());
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      emit(PreviousStep());
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 10),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      yearController.text = formattedDate;
    }
    emit(PickDateDone());
  }

  Future<void> openPDFLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // 👈 افتح الرابط خارج التطبيق
    )) {
      print('❌ لا يمكن فتح الرابط');
    }
  }}
