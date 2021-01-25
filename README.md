# Pokeapp
Pokeapp lists Pokemon and lets user to view their stats and types.

The app is written using Swift 5.3, iOS 11 as development target and MVVM + Coordinators patterns.
UI is created without the use of Storyboard or Xib and support both iPhone and iPad.

Pokeapp use the [PokéAPI](https://pokeapi.co/) v2.
## Screenshots
<p>
<img src="./screenshots/1.png?raw=true" width="200">
<img src="./screenshots/2.png?raw=true" width="200">
<img src="./screenshots/3.png?raw=true" width="200">
</p>
<p>
<img src="./screenshots/4.png?raw=true" width="200">
<img src="./screenshots/5.png?raw=true" width="200">
</p>
<p>
<img src="./screenshots/6.png?raw=true" width="250">
<img src="./screenshots/7.png?raw=true" width="250">
<img src="./screenshots/8.png?raw=true" width="250">
</p>

## APP Mockup
In the project root you can find the Adobe XD mockup project, created before developing the app to have a guideline.
## External libraries
No external library were used, this because I decided to take it as a challenge to improve my skills and better explore some aspects such as caching requests and images.
## APP Flow
Pokeapp start showing the first 20 Pokemon sorted by id. By scrolling down the app will fetch and show 20 new Pokemon every time. When users tap on a Pokemon the app shows his details (name, id, image, weight, height, stats and types) and if they tap on the image an image viewer will open showing all the Pokemon images.
User can also search a Pokemon by typing his name or id in the search bar.
## Caching
API requests and images are cached using [URLCache](https://developer.apple.com/documentation/foundation/urlcache), so the app works even offline with cached data.
## Unit Tests
I wrote some tests for the ViewModels.
## Pokemon stats
I added a progress bar for each stats in the detail page. Max progress bar values are based on Gen VIII Dex from [serebii.net](https://www.serebii.net/pokedex-swsh/stat/hp.shtml)
## Additional features
As an additional feature I decided to insert the Pokemon search.
Users can search by Pokemon name or id. Unfortunately [PokéAPI](https://pokeapi.co/) doesn't have an endpoint for a smart search, so users have to type full Pokemon name to have some result.
