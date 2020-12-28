class Group {

  private ArrayList<Node> group;

  Group() {
    group = new ArrayList<Node>();
  }

  void addnode(final Node tnode) {
    //console.log("added node:" + tnode);
    group.add(tnode);
  }

  Node getnode(final int idx) {
    return group.get(idx);
  }
  
  void exec() {
    exec(null);
  }

  void exec(final Group g) {
    //console.log('executing this grp:'+this.group.length);
    //for (int i = 0 ; i < group.size(); i++) {
      //console.log('this.group idx:'+this.group[i]);
      //if (typeof g !== "undefined") {
      //  console.log('g not undefined');
      //  this.group[i].exec(g);
      //} else {
      //  console.log('g defined:'+g);
      //  this.group[i].exec();
      //}
    //}
    
    for (final Node currentNode : group) {
      currentNode.exec(g);
    }
  }
}
