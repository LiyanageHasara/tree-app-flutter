class Tree{
  String title;
  String description;
  String image;
  String id;

  Tree({this.title, this.description, this.image, this.id});

  Tree.fromMap(Map<String,dynamic> data, String id):
    title=data["title"],
    description=data["description"],
    image=data["image"],
    id=id;

  Map<String, dynamic> toMap(){
    return{
      "title" : title,
      "description" : description,
      "image": image,
    };
  }
}