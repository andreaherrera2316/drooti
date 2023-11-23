abstract class IGameManager {
  //void init();
  void start();
  void pause();
  void resume();
  void end();
  void restart();
}

//good morning love
//today it is i can feel it in my bones
//okay run the game once
//make the gtp changes
//and then see if it works
//we will finish setting it up later
//for now
//we need to uncomment the init function and make the game more organized
//do all of what we talked about
//and then only then
//get the background to work
//once everything is ready
//then once the background is good
//make the game restart
//determine scroes
//fix other little problems (like the view model info)
//then add signup
//with an email
//and password
//they can also have a custom username
//we would call them by that
//and that would pretty much be what we know about them
//this is targeted to kids, i don't exactly want to keep their name
//and other sensitive data like age
//because it's a game and i'd rather not keep that data
//either way
//after that i will set up everything
//and upload
//the tests we can do later
//everything else we can do later
//that the beta versoin
//next version could have rankings and prepare to be released to the app store

//todo
//what is we add a load method to game manager? It's a swell idea
//so we can load the game
//and give the controller a load function
//think  it through

//TODO
//start here
//okay we need all the managers
//to be managed by a managers manager
//the ceo of the managers
//calling the shots
//either way
//then we have to go by each manager
///give them an interface
///and make sure the interface implements game manager
///then we will make sure the methods work

//then here
//then we will go manager by manager
//making interfaces and implementing them
//then we will do a big main game manager
//that will do basically what the controller is doing
//and it will get info from the controller to the corresponding managers
//That should be better
//also the controller should subscirbe the presenter to certain updates there

///////////////////WHY///////////

//Ok after reading my old clean architecture UI article I have realised that
//there should be a request model to get the data for the drone
//and there should be a response model
//where the data comes back

//basically all the managers
//will need a interface
//and we will communicate with it throught that interface
//now there should be a game official manager
//that manager the start pause resume ect

//I have developed a bit or a bad code radar
//So whenever i want to stay away from certain code
//Its because I know its dirty
//Theres a better solution
//And I don't want to come back and fix it
//So I WANT to stay away from it
//But I MAKE myself go back and fix it
