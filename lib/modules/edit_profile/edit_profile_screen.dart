import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/componets/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) => {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        _nameController.text = cubit.model!.name!;
        _bioController.text = cubit.model!.bio!;
        _phoneController.text = cubit.model!.phone!;

        return Scaffold(
          appBar:
              defaultAppBar(leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
                  text: 'Edit Profile', context: context, actions: [
            textBottomItem(
              onPressed: () {
                cubit.updateUserProfile(
                  phone: _phoneController.text,
                  name: _nameController.text,
                  bio: _bioController.text,
                );
              },
              text: 'UPDATE',
            ),
            SizedBox(
              width: 10.0,
            )
          ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(states is SocialUpdateUserLoadingStates)
                    const Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 10.0),
                      child: LinearProgressIndicator(),
                    ),
                  Container(
                    height: 340.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 280.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    image: DecorationImage(
                                      image: cubit.profileCover == null
                                          ? NetworkImage(
                                              '${cubit.model!.cover}')
                                          : FileImage(cubit.profileCover!)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              TextButton(
                                onPressed: () {
                                  cubit.getFromCover();
                                },
                                child: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 20.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 69.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 64.0,
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage(
                                        '${cubit.model!.image}',
                                      )
                                    : FileImage(cubit.profileImage!)
                                        as ImageProvider,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cubit.getFromImage();
                              },
                              child: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                      width: 300.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          editTextFormField(
                              controller: _nameController,
                              type: TextInputType.name,
                              prefix: IconBroken.User),
                        ],
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: 300.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bio',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          editTextFormField(
                              controller: _bioController,
                              type: TextInputType.text,
                              prefix: IconBroken.Info_Circle),
                        ],
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: 300.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          editTextFormField(
                              controller: _phoneController,
                              type: TextInputType.phone,
                              prefix: Icons.phone),
                        ],
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
