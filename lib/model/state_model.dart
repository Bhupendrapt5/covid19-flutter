class States {
  
  final List<dynamic> states;
 
  States({
    // this.stateCode,
    this.states,
  });

  factory States.fromJson(List<dynamic> json) {
    return States(
      states: json,
    );
  }
}