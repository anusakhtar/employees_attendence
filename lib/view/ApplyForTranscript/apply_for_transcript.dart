import 'package:employees_attendence/widgets/custom_botton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../Controller/ApplyForTranscriptController/apply_for_transcript_controller.dart';
import '../../widgets/CustomTextformField.dart';
import '../../widgets/custom_dropdown_button.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../TranscriptRequestDetailPage/transcript_request_deatil_page.dart';

class ApplyForTranscript extends StatefulWidget {
  const ApplyForTranscript({super.key});

  @override
  State<ApplyForTranscript> createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForTranscript> {
  final _formKey = GlobalKey<FormState>();
  String? documentType;
  String? urgency;
  String? originalDuplicate;
  String? transcriptIssued;
  String? degreeIssued;
  String? courseRepeated;
  String? _cnicFileName;
  String? _cnicFilePath;
  String? _passportFileName;
  String? _passportFilePath;
  String? _matricFileName;
  String? _matricFilePath;
  String? _transcriptFileName;
  String? _transcriptFilePath;
  String? passingMat;
  String? isPass;
  String? year;
  String? completionDegree;
  bool isImage = false;
  DateTime? _selectedDate;
  String? _errorUploadCertification;
  String? _errorUploadCNIC;
  String? _errorUploadPassport;
  String? _errorTranscriptFile;
  bool _isChecked = false;
  ApplyForTranscriptController transcriptController =
      Get.put(ApplyForTranscriptController());

  Future<void> _pickFile(Function(String?, String?) setFile) async {
    try {
      // Allow picking only PDF or image files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        // File picked successfully
        PlatformFile file = result.files.first;

        setState(() {
          setFile(file.name, file.path);
          isImage = file.extension != 'pdf';
        });

        // You can now use the file path to read the file, upload it, etc.
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _setCnicFile(String? name, String? path) {
    _cnicFileName = name;
    _cnicFilePath = path;
  }

  void _setPassportFile(FilePickerResult? result) {
    if (result != null) {
      String? path = result.files.single.path;
      if (path != null && _isImageFile(path)) {
        setState(() {
          _passportFilePath = path;
          _passportFileName = result.files.single.name;
        });
      } else {
        // Show error message if the selected file is not an image
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a valid image file')),
        );
      }
    }
  }

  bool _isImageFile(String path) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    final extension = path.split('.').last.toLowerCase();
    return imageExtensions.contains(extension);
  }

  void _pickedFile(Function(FilePickerResult?) onFilePicked) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    onFilePicked(result);
  }

  void _setMatricFile(String? name, String? path) {
    setState(() {
      _matricFileName = name;
      _matricFilePath = path;
    });
  }

  void _setTranscriptFile(String? name, String? path) {
    setState(() {
      _transcriptFileName = name;
      _transcriptFilePath = path;
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        DOBController!.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  TextEditingController? DOBController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Request For Degree'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Document Type ',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropdownButton(
                      value: documentType,
                      options: ['Degree', 'Transcript'],
                      onChanged: (String? newValue) {
                        setState(() {
                          documentType = newValue;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Please select a document type'
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Normal/Urgent',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropdownButton(
                      value: urgency,
                      options: ['Normal', 'Urgent'],
                      onChanged: (String? newValue) {
                        setState(() {
                          urgency = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select Normal/Urgent' : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Original/Duplicate',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropdownButton(
                      value: originalDuplicate,
                      options: ['Original', 'Duplicate'],
                      onChanged: (String? newValue) {
                        setState(() {
                          originalDuplicate = newValue;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Please select original/Duplicate'
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Any transcript already issued?',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropdownButton(
                      value: transcriptIssued,
                      options: ['Yes', 'No'],
                      onChanged: (String? newValue) {
                        setState(() {
                          transcriptIssued = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select an option' : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Any Degree already issued? ',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropdownButton(
                      value: degreeIssued,
                      options: ['Yes', 'No'],
                      onChanged: (String? newValue) {
                        setState(() {
                          degreeIssued = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select an option' : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Have you repeated any course? ',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDropdownButton(
                      value: courseRepeated,
                      options: ['Yes', 'No'],
                      onChanged: (String? newValue) {
                        setState(() {
                          courseRepeated = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select an option' : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Name (as per matriculation certificate) ',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: 'Enter Your Name',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'CNIC No',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Your CNIC No',
                      validator: (value) =>
                          value == null || value.isEmpty || value.length != 13
                              ? 'Please enter your CNIC No'
                              : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Date of Birth',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: DOBController,
                      onTapSuffixIcon: () {
                        _pickDate(context);
                      },
                      suffixIcon: Icons.calendar_month,
                      hintText: 'Enter Your DOB',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your date of birth'
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text:
                                "Father's Name (as per matriculation certificate)",
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: 'Enter Your Father\'s Name',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your father\'s name'
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Email',
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        hintText: 'Enter Your Email',
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])')
                                  .hasMatch(value!)) {
                            return "Please enter the correct Email";
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Cell',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Your Cell No',
                      validator: (value) =>
                          value == null || value.isEmpty || value.length != 11
                              ? 'Please enter your cell number'
                              : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: 'Portal Address',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      height: 150,
                      hintText: 'Enter your Portal Address',
                      maxLines: 5,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your portal address'
                          : null,
                    ),
                    if (documentType != null && documentType != '') ...[
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Original CNIC (both sides) ',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (_cnicFilePath != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                child: isImage
                                    ? Image.file(
                                        File(_cnicFilePath!),
                                        fit: BoxFit.cover,
                                      )
                                    : PDFView(
                                        filePath: _cnicFilePath!,
                                        enableSwipe: true,
                                        swipeHorizontal: false,
                                        autoSpacing: false,
                                        pageFling: false,
                                        onRender: (pages) {
                                          print("Rendered $pages pages");
                                        },
                                        onError: (error) {
                                          print(error.toString());
                                        },
                                        onPageError: (page, error) {
                                          print('$page: ${error.toString()}');
                                        },
                                        onViewCreated: (PDFViewController vc) {
                                          setState(() {});
                                        },
                                        onPageChanged: (int? page, int? total) {
                                          setState(() {});
                                          print('page change: $page/$total');
                                        },
                                      ),
                              ),
                            ),
                          CustomBotton(
                            onTap: () {
                              setState(() {
                                _pickFile(_setCnicFile);
                              });
                            },
                            label: 'Upload CNIC',
                          ),
                          if (_cnicFileName != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$_cnicFileName'),
                            ),
                          if (_errorUploadCNIC != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _errorUploadCNIC!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      /////

                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Passport Sized Picture',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (_passportFilePath != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.file(
                                  File(_passportFilePath!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          CustomBotton(
                            onTap: () {
                              setState(() {
                                _pickedFile(_setPassportFile);
                                // Clear the error message when the button is pressed
                                _errorUploadPassport = null;
                              });
                            },
                            label: 'Upload Image',
                          ),
                          if (_passportFileName != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Selected file: $_passportFileName'),
                            ),
                          // Show error message if Passport Sized Picture file is not uploaded
                          if (_errorUploadPassport != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _errorUploadPassport!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Matriculation Certificate (Sanad)',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (_matricFilePath != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                child: isImage
                                    ? Image.file(
                                        File(_matricFilePath!),
                                        fit: BoxFit.cover,
                                      )
                                    : PDFView(
                                        filePath: _matricFilePath!,
                                        enableSwipe: true,
                                        swipeHorizontal: false,
                                        autoSpacing: false,
                                        pageFling: false,
                                        onRender: (pages) {
                                          print("Rendered $pages pages");
                                        },
                                        onError: (error) {
                                          print(error.toString());
                                        },
                                        onPageError: (page, error) {
                                          print('$page: ${error.toString()}');
                                        },
                                        onViewCreated: (PDFViewController vc) {
                                          setState(() {});
                                        },
                                        onPageChanged: (int? page, int? total) {
                                          setState(() {});
                                          print('page change: $page/$total');
                                        },
                                      ),
                              ),
                            ),
                          CustomBotton(
                            onTap: () {
                              setState(() {
                                _pickFile(_setMatricFile);
                              });
                            },
                            label: 'Upload Certificate',
                          ),
                          if (_matricFileName != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$_matricFileName'),
                            ),
                          if (_errorUploadCertification != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _errorUploadCertification!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      if (documentType == 'Degree') ...[
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Transcript Picture (MUL)',
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_transcriptFilePath != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: isImage
                                  ? Image.file(
                                      File(_transcriptFilePath!),
                                      fit: BoxFit.cover,
                                    )
                                  : PDFView(
                                      filePath: _transcriptFilePath!,
                                      enableSwipe: true,
                                      swipeHorizontal: false,
                                      autoSpacing: false,
                                      pageFling: false,
                                      onRender: (pages) {
                                        print("Rendered $pages pages");
                                      },
                                      onError: (error) {
                                        print(error.toString());
                                      },
                                      onPageError: (page, error) {
                                        print('$page: ${error.toString()}');
                                      },
                                      onViewCreated: (PDFViewController vc) {
                                        setState(() {});
                                      },
                                      onPageChanged: (int? page, int? total) {
                                        setState(() {});
                                        print('page change: $page/$total');
                                      },
                                    ),
                            ),
                          ),
                        CustomBotton(
                          onTap: () {
                            setState(() {
                              _pickFile(_setTranscriptFile);
                            });
                          },
                          label: 'Upload Transcript',
                        ),
                        if (_transcriptFileName != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$_transcriptFileName'),
                          ),
                        if (_errorTranscriptFile != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorTranscriptFile!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                      const SizedBox(height: 20),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                              children: [
                            TextSpan(
                              text: 'Completion of degree with?',
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            )
                          ])),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomDropdownButton(
                        value: completionDegree,
                        options: ['CourseWork', 'Thesis'],
                        onChanged: (String? newValue) {
                          setState(() {
                            completionDegree = newValue;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Please select completion of Degree'
                            : null,
                      ),

                      if (documentType == 'Transcript') ...[
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                text:
                                    'Passing of MAT (Minhaj Aptitude Test) / NTS GAT',
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              )
                            ])),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomDropdownButton(
                          value: passingMat,
                          options: ['MAT', 'GAT'],
                          onChanged: (String? newValue) {
                            setState(() {
                              passingMat = newValue;
                            });
                          },
                          validator: (value) => value == null
                              ? 'Please select passing of MAt'
                              : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                text: 'Is passed?',
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              )
                            ])),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomDropdownButton(
                          value: isPass,
                          options: ['Yes', 'No'],
                          onChanged: (String? newValue) {
                            setState(() {
                              isPass = newValue;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Please select the option' : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                text: 'Year',
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              )
                            ])),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomDropdownButton(
                          value: year,
                          options: [
                            '2024',
                            '2023',
                            '2022',
                            '2021',
                            '2020',
                            '2019'
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              year = newValue;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Please select year' : null,
                        ),
                      ],
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    CustomBotton(
                      label: 'Submit',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                        setState(() {
                          bool hasError = false; // Track if there's any error

                          if (_matricFilePath == null) {
                            _errorUploadCertification = 'Please upload the Matriculation Certificate.';
                            hasError = true; // Set hasError to true if there's an error
                          } else {
                            _errorUploadCertification = null; // Clear the error message if there's no error
                          }
                          if (_cnicFilePath == null) {
                            _errorUploadCNIC = 'Please upload the Original CNIC';
                            hasError = true; // Set hasError to true if there's an error
                          } else {
                            _errorUploadCNIC = null; // Clear the error message if there's no error
                          }

                          if (_passportFilePath == null) {
                            _errorUploadPassport = 'Please upload your Image';
                            hasError = true; // Set hasError to true if there's an error
                          } else {
                            _errorUploadPassport = null; // Clear the error message if there's no error
                          }
                          if (_transcriptFilePath == null) {
                            _errorTranscriptFile = 'Please upload your transcript';
                            hasError = true; // Set hasError to true if there's an error
                          } else {
                            _errorTranscriptFile = null; // Clear the error message if there's no error
                          }

                          if (!hasError) {
                          if (documentType == 'Degree') {
                            _showDegreeNoticeBox(context);
                          } else if (documentType == 'Transcript') {
                            _showTranscriptNoticeBox(context);
                          }
                          }
                        });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDegreeNoticeBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Processing Fee & Details',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Processing Fee: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'Rs. 3000\n\n'),
                      TextSpan(
                        text: 'Issuance Period: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'Within 38 working days\n\n'),
                      TextSpan(
                        text: '1. Passport Size ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              'picture (preferably most recent one) having a '),
                      TextSpan(
                        text: 'blue background.\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              '2. For Masters students who have not attempted '),
                      TextSpan(
                        text: 'MAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              ' (Minhaj Aptitude Test) only the original result of '),
                      TextSpan(
                        text: 'NTS GAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' will be accepted.\n\n'),
                      TextSpan(text: '3. Image of '),
                      TextSpan(
                        text: 'Matriculation Certificate (Sanad)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              ' is mandatory. Result intimation or Screenshot of the website shall not be accepted.\n\n'),
                      TextSpan(text: '4. Image of '),
                      TextSpan(
                        text: 'Original CNIC',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' The CNIC must be valid (not expired).\n\n',
                      ),
                      TextSpan(
                          text:
                              '5. All attachments must be clearly scanned, blurry documents shall be discarded and the application will not be proceeded.'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: transcriptController.isCheckedDegree.value,
                        onChanged:(newValue){
                          transcriptController.onChangedDegree(newValue);
                        }),
                    ),
                    Text("I have read all the above")
                  ],
                ),

              ],
            ),
          ),
          actions: [
            CustomBotton(
              width: 100,
              height: 40,
              backgroundColor: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
              },
              label: 'Close',
            ),
            CustomBotton(
              width: 100,
              height: 40,
              backgroundColor: Colors.deepPurple,
              onTap: () {
                if (transcriptController.isCheckedDegree.value) {
                  Navigator.of(context).pop();
                  Get.to(() => const TranscriptRequest());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                } else {
                  // Show a message indicating that the checkbox must be checked
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please confirm that you have read all the above')),
                  );
                }
              },
              label: 'Submit',
            ),
          ],
        );
      },
    );
  }

  void _showTranscriptNoticeBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Processing Fee & Details',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Processing Fee: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'Rs. 2000\n\n'),
                      TextSpan(
                        text: 'Issuance Period: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'Within 35 working days\n\n'),
                      TextSpan(
                        text: '1. Passport Size ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              'picture (preferably most recent one) having a '),
                      TextSpan(
                        text: 'blue background.\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              '2. For Masters students who have not attempted '),
                      TextSpan(
                        text: 'MAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              ' (Minhaj Aptitude Test) only the original result of '),
                      TextSpan(
                        text: 'NTS GAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' will be accepted.\n\n'),
                      TextSpan(text: '3. Image of '),
                      TextSpan(
                        text: 'Matriculation Certificate (Sanad)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              ' is mandatory. Result intimation or Screenshot of the website shall not be accepted.\n\n'),
                      TextSpan(text: '4. Image of '),
                      TextSpan(
                        text: 'Original CNIC',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' The CNIC must be valid (not expired).\n\n',
                      ),
                      TextSpan(
                          text:
                              '5. All attachments must be clearly scanned, blurry documents shall be discarded and the application will not be proceeded.'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: transcriptController.isCheckedTranscript.value,
                        onChanged:(newValue){
                          transcriptController.onChangedTranscript(newValue);
                        }),
                    ),
                    Text("I have read all the above")
                  ],
                ),
              ],
            ),
          ),
          actions: [
          Row( // Wrap buttons and checkbox in a Row
          mainAxisAlignment: MainAxisAlignment.end, // Align to the end (left side)
          children: [
            CustomBotton(
              width: 100,
              height: 40,
              backgroundColor: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
              },
              label: 'Close',
            ),
            SizedBox(width: 10), // Add spacing between buttons
            CustomBotton(
              width: 100,
              height: 40,
              backgroundColor: Colors.deepPurple,
              onTap: () {
                if (transcriptController.isCheckedTranscript.value == true ) {

                  Navigator.of(context).pop();
                  Get.to(() => const TranscriptRequest());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please confirm that you have read all the above'),
                    ),
                  );
                }
              },
              label: 'Submit',
            ),
          ],
          )
          ]
        );
      },
    );
  }
}
