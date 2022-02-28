#  Babbel Game

This is an assignment for the interview at Babbel. Done by Abbas SabetiNezhad.

## Time:

I have invested about 5 hours on this assignment. The distribution of these 5 hours is as follows:

    1. The architecture : 30 min
    2. UI and animations: 1 h
    3. Game flow: 1.5 h
    5. Writing TestDoubles: 15 min
    4. Writing tests: 1 h
    5. Writing this doc: 15 min
    6. Some final touches on code style: 30 min

## Decisions:

There has been some decisions for having a sensible flow in the game, including:

1. I have tried to create the architecture based on POP (Protocol Oriented Programming), to be ready to create a test double for any component that I need, so that I can write tests for every component easily, without being worried about recreating that element.

2. Since it could be so boring if there is a long list of wrong meanings, I decided to choose between 3 to 9 Random wrong meanings for each word to show. Since it could be again so boring that the correct meaning comes too late, I show the correct meaning with a probability of 0.3 on each transition.
    
3. I shuffle the list of words before each selection for wrong meanings of each word. I know that shuffle takes time complexity of order n and doing that for each word could end in a n^2 operation. But since we are using a limited amount of words, I used this approach anyway. probably if we have more time and resources, it could be better to have a list of words which is more likely to get mistaken with each other, so the game could be more challenging for the players to detect the correct meaning among others.
    
4. For testing, I defined some test doubles for each of Interactor, Presenter and Worker to use them for testing each element individually. I defined some Stub Workers for using in testing of the interactor; Simply because I needed to get different situations easily without being worried of simulating a correct or incorrect word guess. The Delegate for interactor and also the test double for interactor itself, has been defined as spy to get notified easily on different outcomes of testing process, and making them compatible with expectations in the XCTest framework.

5. Another point which I have been thinking of, is how we are going to route to the other pages from first screen in the future. I think NavigationLink, could cause the architecture a little bit messy, since we have to provide the next view right in the first view, which can cause adding views to presenter or adding logic to view for opening the next screen. I have defined the transitions like what we usually do in UIKit. part of this is happing in a class function in the SceneDelagte, which is accessible everywhere using a static variable. Since we don't use it for any saving state or sharing data, I think this is a good workaround for keeping the architecture neat and not misusing elements by mistake. Router is responsible for creating the requirements for each scene and calling SceneDelegate class function to navigate among screens. We probably also need some other methods there if we are gonna use different navigationControllers for nested flows in the app.

## Room for improvement:

1. It's a good idea to add some predictable game scenario to add UITest to the application. For instance, if we could create a scenario which the meanings which came in the third transition is always correct, we could made a flow for winning the game for any player and the test the conditions over it. I didn't find the time to do it. But it's not a bad idea to have some UI Test for it.
    
2. It's better to have a better data structure for repressenting related or similar words to show the meaning of them interchangably, to challenge the players in learning the meaning of words.
    
3. Some UI Improvement could be useful and more interesting for users. Since it's extremely important to keep the users engaged for being impactful on their learning process.
    
4. I would really like to use some more advanced approach for dependency injection in the app, (e.g. using property wrappers) instead of just creating and passing the element each time in the constructor. This could make this source code a lot more cleaner and easier to write all the tests.
    
5. Adding networking to get a broader source of words and languages could be the next most important step.
    
    

I hope I have demonstrated my understanding of the problem and my plans for improving this assignment.

Thank you.

Written by Abbas SabetiNezhad
