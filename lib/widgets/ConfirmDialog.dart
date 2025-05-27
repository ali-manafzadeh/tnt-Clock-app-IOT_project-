import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void showConfirmDialog(
  BuildContext context,
  Function() function, [
  String? message,
]) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Icon(
                Iconsax.trash,
                color: Colors.red,
                size: 86,
              ),
            ),
            if (message != null) ...[
              Text(
                message,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
            ],
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(1),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // context.read<DetailPhotoCubit>().downloadPhoto(
                        //     context, photo.src.original, false);
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15)),
                        ),
                      ),
                      icon: Icon(CupertinoIcons.back, color: Colors.black),
                      label: Text(
                        "cancel",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors
                                  .black, // Set your desired text color here
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(1),
                    child: OutlinedButton.icon(
                      onPressed: function,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15)),
                        ),
                      ),
                      icon: Icon(CupertinoIcons.forward, color: Colors.white),
                      label: Text(
                        "Delete",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: const Color.fromARGB(255, 255, 255,
                                  255), // Set your desired text color here
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

// ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: ValueListenableBuilder(
//             valueListenable: DatabaseHandler.databaseBox.listenable(),
//             builder: (context, Box databaseBox, _) {
//               final dataIndex = databaseBox.keys.map((key) {
//                 final value = databaseBox.get(key);
//                 return {
//                   "key": key,
//                   "url": value["url"],
//                   "name": value['name'],
//                   "format": value['format'],
//                 };
//               }).toList();
//               _items = dataIndex.reversed.toList();
//               return ListView.builder(
//                 itemCount: _items.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var currentItem = _items[index];
//                   return Column(
//                     children: [
//                       index == 0
//                           ? getSelectedItemsList().isNotEmpty
//                               ? Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.deepPurple,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 3),
//                                   height: 50,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Material(
//                                         color: Colors.transparent,
//                                         child: Text(
//                                           '${getSelectedItemsList().length}',
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           FadeInAnimation(
//                                             delay: 1,
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           12)),
//                                               child: Row(
//                                                 children: [
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         showTextFieldDialog(
//                                                             context,
//                                                             'FolderName');
//                                                       },
//                                                       icon: Icon(
//                                                         Iconsax.folder_add,
//                                                         color:
//                                                             Colors.deepPurple,
//                                                       )),
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         showConfirmDialog(
//                                                             context,
//                                                             1,
//                                                             'are u sure?');
//                                                       },
//                                                       icon: Icon(
//                                                         Iconsax.trash,
//                                                         color: Colors.red,
//                                                       )),
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         _deselectItemsOnBack();
//                                                         widget.onSelectionChanged(
//                                                             getSelectedItemsList());
//                                                       },
//                                                       icon: const Icon(
//                                                         Icons.close,
//                                                         color:
//                                                             Colors.deepPurple,
//                                                       )),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               : Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.deepPurple,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   padding:
//                                       const EdgeInsets.only(left: 12, right: 6),
//                                   height: 50,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Material(
//                                         color: Colors.transparent,
//                                         child: Text(
//                                           'Name',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                       ElevatedButton(
//                                         style: ButtonStyle(
//                                           padding: MaterialStateProperty.all<
//                                                   EdgeInsets>(
//                                               EdgeInsets.symmetric(
//                                                   horizontal:
//                                                       10)), // Add padding here
//                                           shape: MaterialStateProperty.all<
//                                               RoundedRectangleBorder>(
//                                             RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(12.0),
//                                               // side: BorderSide(color: Colors.red)
//                                             ),
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             _selectedItems[1] = true;
//                                           });
//                                           widget.onSelectionChanged(
//                                               getSelectedItemsList());
//                                         },
//                                         child: Text(
//                                           'Create Folder',
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       )

//                                       //  Icon(
//                                       //   widget.format == 'file_text'
//                                       //       ? Iconsax.folder_25
//                                       //       : widget.format == 'music_text'
//                                       //           ? Iconsax.music_filter
//                                       //           : widget.format == 'video_text'
//                                       //               ? Iconsax.video_play
//                                       //               : widget.format == 'docs_text'
//                                       //                   ? Iconsax.document5
//                                       //                   : Iconsax.call_outgoing,
//                                       //   color: Colors.white,
//                                       // ),
//                                     ],
//                                   ),
//                                 )
//                           : GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   if (getSelectedItemsList().isNotEmpty) {
//                                     _selectedItems[index] =
//                                         !_selectedItems[index];
//                                     widget.onSelectionChanged(
//                                         getSelectedItemsList());
//                                   }
//                                 });
//                               },
//                               onLongPress: () {
//                                 setState(() {
//                                   _selectedItems[index] = true;
//                                 });
//                                 widget
//                                     .onSelectionChanged(getSelectedItemsList());
//                               },
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Card(
//                                       color: _selectedItems[index]
//                                           ? Colors.grey
//                                           : null,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: themeData.flashCard),
//                                             borderRadius:
//                                                 BorderRadius.circular(12)),
//                                         padding: EdgeInsets.only(
//                                             right: 0,
//                                             left: getSelectedItemsList()
//                                                     .isNotEmpty
//                                                 ? 0
//                                                 : 12),
//                                         height: 50,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 getSelectedItemsList()
//                                                         .isNotEmpty
//                                                     ? Checkbox(
//                                                         shape: const RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius.all(
//                                                                     Radius.circular(
//                                                                         5.0))),
//                                                         side: const BorderSide(
//                                                           color: Colors.grey,
//                                                           width: 2,
//                                                         ),
//                                                         value: _selectedItems[
//                                                             index],
//                                                         onChanged:
//                                                             (bool? newValue) {
//                                                           setState(() {
//                                                             // Update the item's selection state based on the checkbox.
//                                                             _selectedItems[
//                                                                     index] =
//                                                                 newValue ??
//                                                                     false;
//                                                             widget.onSelectionChanged(
//                                                                 getSelectedItemsList());
//                                                           });
//                                                         },
//                                                         activeColor: Colors
//                                                             .deepPurple, // Use your theme color for the checkbox.
//                                                       )
//                                                     : Container(),
//                                                 Text(
//                                                   currentItem['name'],
//                                                   style: const TextStyle(
//                                                       fontSize: 16),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 8),
//                                                   child: Icon(
//                                                     widget.format == 'file_text'
//                                                         ? Iconsax.folder_open
//                                                         : widget.format ==
//                                                                 'music_text'
//                                                             ? Iconsax.music_play
//                                                             : widget.format ==
//                                                                     'video_text'
//                                                                 ? Iconsax
//                                                                     .video_circle
//                                                                 : widget.format ==
//                                                                         'docs_text'
//                                                                     ? Iconsax
//                                                                         .document5
//                                                                     : Iconsax
//                                                                         .call_outgoing,
//                                                     color: Colors.deepPurple,
//                                                   ),
//                                                 ),
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       widget.callback(
//                                                           currentItem['key']);
//                                                     },
//                                                     icon: Icon(
//                                                       Iconsax.menu_15,
//                                                       color: Colors.deepPurple,
//                                                     )),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                     ],
//                   );
//                 },
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//               );
//             },
//           )),
