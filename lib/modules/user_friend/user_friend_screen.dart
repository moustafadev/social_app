import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/user_model.dart';

import 'package:social/shared/styles/icon_broken.dart';

class UserFriendsScreen extends StatelessWidget {

  SocialUserModel model;
  UserFriendsScreen({Key? key,
    required this.model
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 340.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 280.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    topRight: Radius.circular(7.0)),
                                image: DecorationImage(
                                  image: NetworkImage('${model.cover}'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        CircleAvatar(
                          radius: 68.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 64.0,
                            backgroundImage: NetworkImage(
                              '${model.image}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 25.0),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          '${model.bio}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: Colors.blueAccent,
                          onPressed: () {

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Add_User,size: 18.0,color: Colors.white,),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add Friend',
                                style: TextStyle(color: Colors.white),
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.blueAccent,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Send,size: 18.0,color: Colors.white,),
                              SizedBox(
                                width: 5.0,
                              ),
                              const Text(
                                'Message',
                                style: TextStyle(color: Colors.white),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Post'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Post'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Post'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text('Post'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Friends',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text('7 Friends'),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Wrap(
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 7),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://image.freepik.com/free-photo/travel-agent-hearing-customer-desires-portrait-good-looking-european-businesswoman-blue-blouse-glasses-holding-hands-pockets-smiling-being-friendly-polite-gray-wall_176420-25025.jpg'),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 117.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Ahmed Mostafa',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 7),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://image.freepik.com/free-photo/travel-agent-hearing-customer-desires-portrait-good-looking-european-businesswoman-blue-blouse-glasses-holding-hands-pockets-smiling-being-friendly-polite-gray-wall_176420-25025.jpg'),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 117.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Ahmed Mostafa',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 7),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://image.freepik.com/free-photo/travel-agent-hearing-customer-desires-portrait-good-looking-european-businesswoman-blue-blouse-glasses-holding-hands-pockets-smiling-being-friendly-polite-gray-wall_176420-25025.jpg'),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 117.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Ahmed Mostafa',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 7),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://image.freepik.com/free-photo/travel-agent-hearing-customer-desires-portrait-good-looking-european-businesswoman-blue-blouse-glasses-holding-hands-pockets-smiling-being-friendly-polite-gray-wall_176420-25025.jpg'),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 117.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Ahmed Mostafa',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 7),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://image.freepik.com/free-photo/travel-agent-hearing-customer-desires-portrait-good-looking-european-businesswoman-blue-blouse-glasses-holding-hands-pockets-smiling-being-friendly-polite-gray-wall_176420-25025.jpg'),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 117.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Ahmed Mostafa',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(end: 7),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://image.freepik.com/free-photo/travel-agent-hearing-customer-desires-portrait-good-looking-european-businesswoman-blue-blouse-glasses-holding-hands-pockets-smiling-being-friendly-polite-gray-wall_176420-25025.jpg'),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 117.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Ahmed Mostafa',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Center(
                            child: MaterialButton(
                              minWidth: double.infinity,
                              color: Colors.grey[200],
                              onPressed: () {},
                              child: Text(
                                'See All Friendes',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
