//Tree model
class Tree {
  String treeTitle;
  String treeDescription;
  String treeImage;
  String treeId;

  //create constructor
  Tree({this.treeTitle, this.treeDescription, this.treeImage, this.treeId});

  //return tree from map
  Tree.fromMap(Map<String, dynamic> data, String treeId)
      : treeTitle = data["treeTitle"],
        treeDescription = data["treeDescription"],
        treeImage = data["treeImage"],
        treeId = treeId;

  Map<String, dynamic> toMap() {
    return {
      "treeTitle": treeTitle,
      "treeDescription": treeDescription,
      "treeImage": treeImage,
    };
  }
}
