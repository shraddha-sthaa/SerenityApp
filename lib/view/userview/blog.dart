import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serenity/controller/blogcontroller.dart';
import 'package:serenity/model/blog_model.dart';
import 'package:serenity/utilis/remoteservices.dart';
import 'package:serenity/view/userview/readblog.dart';

class BlogView extends StatelessWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Blog",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<BlogPageController>(
                  init: BlogPageController(),
                  builder: (controller) {
                    return controller.loading
                        ? Center(child: Image.asset("assets/loading.gif"))
                        : controller.blog.isEmpty
                            ? Column(
                                children: [
                                  Image.asset("assets/notfound.gif"),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.getBlog();
                                    },
                                    child: const Text("Referesh"),
                                  ),
                                ],
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: controller.blog.length,
                                itemBuilder: (context, index) {
                                  BlogModel blog = controller.blog[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReadBlogView(
                                            model: blog,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      // color: Colors.orange[200],
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: width,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    RemoteServices.initialUrl +
                                                        '/blog/blogfiles/' +
                                                        blog.blogImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // ignore: prefer_const_constructors
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              blog.blogTitle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
