import 'package:flutter/material.dart';
import 'package:friendsapp/app/controllers/friendscontroller.dart';
import 'package:friendsapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class FriendListPage extends GetView<FriendsController> {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Friends'),
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addfriend);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: false,        
              onChanged: (value) {
                controller.currentquery.value = value;
              },
              decoration: const InputDecoration(
                isDense: true,
                filled: true,     
                fillColor: Colors.white,
                border: OutlineInputBorder(
                   borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
                labelText: 'Search Friend',
                hintText: 'Enter name to search',
                suffixIcon: Icon(Icons.search_outlined),
              ),
            ),
          ),
          Expanded(
            child: controller.obx(
                (friends) => friends != null && friends.isNotEmpty
                    ? ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          var friend = friends[index];
                          return ListTile(
                            isThreeLine: true,
                            leading: Text(friend.id.toString()),
                            title: Row(
                              children: [
                                Text(
                                  "${friend.fname} ",
                                ),
                                Text(
                                  "${friend.lname}",
                                )
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mobile : ${friend.mobile}'),
                                Text('Email : ${friend.email}'),
                              ],
                            ),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.updatefriend,
                                          arguments: friend);
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      controller.deleteaFriend(friend);
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("No Friends"),
                      ),
                onLoading: const Center(
                  child: CircularProgressIndicator(),
                ),
                onEmpty: const Center(
                  child: Text("No Friends Yet."),
                ),
                onError: (error) => Center(
                      child: Text(" $error"),
                    )),
          ),
        ],
      ),
    );
  }
}
