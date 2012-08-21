class Recording {
  ArrayList events;

  Recording() {
    events = new ArrayList();
  }

  ArrayList addEvent(int[] obj) {
    events.add(obj);
    return events;
  }

  ArrayList getEvents() {
    return events;
  }

  void trimEvents() {
    int startIndex = 0;
    int endIndex = events.size()-1;

    // walk through until you find the first thing that isn't false
    for (int i = 0; i < events.size(); i++) {
      int[] event = (int[]) events.get(i);
      if(event[0] == 99999) {
        startIndex++;
      } else {
        break;
      }
    }

    for (int i = events.size()-1; i >= 0; i--) { 
      int[] event = (int[]) events.get(i);
      if(event[0] == 99999) {
        endIndex--;
      } else {
        break;
      }
    }

    // now remove from front to first real node
    events.subList(endIndex, events.size()).clear();
    events.subList(0, startIndex).clear();

    // now return the size of events
    // println("Beginning is" + startIndex);
    // println("End is" + endIndex);
  }

  String asString() {
    String[] output = new String[events.size()];
    for (int i=0; i<events.size(); i++) {
      int[] event = (int[]) events.get(i);
      if(event[0] == 99999) {
        output[i] = "false";
      } else {
        output[i] = "[" + str(event[0]) + "," + str(event[1]) + "]";
      }
    }

    return join(output, ", ");
  }

  int eventsLength() {
    return events.size();
  }

  int[] getEvent(int i) {
    return (int[]) events.get(i);
  }
}