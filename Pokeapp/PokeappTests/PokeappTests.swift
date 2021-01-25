//
//  PokeappTests.swift
//  PokeappTests
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import XCTest
@testable import Pokeapp

class PokeappTests: XCTestCase {
    
    static let pokemonModel = PokemonModel(
        id: 1,
        name: "bulbasaur",
        height: 7,
        weight: 69,
        sprites: Sprites(
            backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
            backFemale: nil,
            backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
            backShinyFemale: nil,
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            frontFemale: nil,
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
            frontShinyFemale: nil,
            other: Other(
                dreamWorld: DreamWorld(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg",
                    frontFemale: nil
                ),
                officialArtwork: OfficialArtwork(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
                )
            )
        ),
        stats: [
            Stats(
                baseStat: 45,
                effort: 0,
                stat: Stat(
                    name: "hp",
                    url: "https://pokeapi.co/api/v2/stat/1/"
                )
            ),
            Stats(
                baseStat: 49,
                effort: 0,
                stat: Stat(
                    name: "attack",
                    url: "https://pokeapi.co/api/v2/stat/2/"
                )
            ),
            Stats(
                baseStat: 49,
                effort: 0,
                stat: Stat(
                    name: "defense",
                    url: "https://pokeapi.co/api/v2/stat/3/"
                )
            ),
            Stats(
                baseStat: 65,
                effort: 0,
                stat: Stat(
                    name: "special-attack",
                    url: "https://pokeapi.co/api/v2/stat/4/"
                )
            ),
            Stats(
                baseStat: 65,
                effort: 0,
                stat: Stat(
                    name: "special-defense",
                    url: "https://pokeapi.co/api/v2/stat/5/"
                )
            ),
            Stats(
                baseStat: 45,
                effort: 0,
                stat: Stat(
                    name: "speed",
                    url: "https://pokeapi.co/api/v2/stat/6/"
                )
            )
        ],
        types: [
            TypeElement(
                slot: 1,
                type: Type(
                    name: "grass",
                    url: "https://pokeapi.co/api/v2/type/12/"
                )
            ),
            TypeElement(
                slot: 2,
                type: Type(
                    name: "poison",
                    url: "https://pokeapi.co/api/v2/type/4/"
                )
            )
        ]
    )
    
    class FakeMainCoordinator: MainCoordinator {
        override func getPokemons(offset: Int, onSuccess: ((MainModel, [PokemonModel]) -> Void)?, onError: (() -> Void)?) {
            onSuccess?(
                MainModel(count: 1118, next: "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20", previous: nil, results: []),
                [PokeappTests.pokemonModel]
            )
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainViewModel(){
        let mainViewModel = MainViewModel()
        mainViewModel.coordinator = FakeMainCoordinator(navigationController: SwipeBackNavigationController())
        
        mainViewModel.getPokemons(offset: 0) {
            XCTAssertEqual(mainViewModel.nextOffset, 20)
            XCTAssertEqual(mainViewModel.nextPageURL, URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20"))
            XCTAssertEqual(mainViewModel.pokemons, [PokemonViewModel(pokemonModel: PokeappTests.pokemonModel)])
        } onError: {}
    }

    func testPokemonViewModel() {
        let pokemonViewModel = PokemonViewModel(pokemonModel: PokeappTests.pokemonModel)
        
        XCTAssertEqual(pokemonViewModel.id, 1)
        XCTAssertEqual(pokemonViewModel.name, "Bulbasaur")
        XCTAssertEqual(pokemonViewModel.type, PokemonType.grass)
        XCTAssertEqual(pokemonViewModel.imageURL, URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))
    }
    
    func testDetailViewModel(){
        let detailViewModel = DetailViewModel(pokemonModel: PokeappTests.pokemonModel)
        
        XCTAssertEqual(detailViewModel.id, 1)
        XCTAssertEqual(detailViewModel.namedId, "#001")
        XCTAssertEqual(detailViewModel.name, "Bulbasaur")
        XCTAssertEqual(detailViewModel.type, PokemonType.grass)
        XCTAssertEqual(detailViewModel.imageURL, URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))
        XCTAssertEqual(detailViewModel.weight, "6.9 Kg")
        XCTAssertEqual(detailViewModel.height, "0.7 m")
        XCTAssertEqual(
            detailViewModel.stats,
            [
                StatsViewModel(
                    stats: Stats(
                        baseStat: 45,
                        effort: 0,
                        stat: Stat(
                            name: "hp",
                            url: "https://pokeapi.co/api/v2/stat/1/"
                        )
                    )
                ),
                StatsViewModel(
                    stats: Stats(
                        baseStat: 49,
                        effort: 0,
                        stat: Stat(
                            name: "attack",
                            url: "https://pokeapi.co/api/v2/stat/2/"
                        )
                    )
                ),
                StatsViewModel(
                    stats: Stats(
                        baseStat: 49,
                        effort: 0,
                        stat: Stat(
                            name: "defense",
                            url: "https://pokeapi.co/api/v2/stat/3/"
                        )
                    )
                ),
                StatsViewModel(
                    stats: Stats(
                        baseStat: 65,
                        effort: 0,
                        stat: Stat(
                            name: "special-attack",
                            url: "https://pokeapi.co/api/v2/stat/4/"
                        )
                    )
                ),
                StatsViewModel(
                    stats: Stats(
                        baseStat: 65,
                        effort: 0,
                        stat: Stat(
                            name: "special-defense",
                            url: "https://pokeapi.co/api/v2/stat/5/"
                        )
                    )
                ),
                StatsViewModel(
                    stats: Stats(
                        baseStat: 45,
                        effort: 0,
                        stat: Stat(
                            name: "speed",
                            url: "https://pokeapi.co/api/v2/stat/6/"
                        )
                    )
                )
            ]
        )
    }
    
    // Stats max values are based on https://www.serebii.net/pokedex-swsh/stat/hp.shtml
    func testStatsViewModelHP(){
        let statsViewModel = StatsViewModel(stats: Stats(baseStat: 45, effort: 0, stat: Stat(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")))
        
        XCTAssertEqual(statsViewModel.name, "HP")
        XCTAssertEqual(statsViewModel.value, 45)
        XCTAssertEqual(statsViewModel.progressValue, 45/255) // Gen VIII Dex max HP = 255
    }
    
    func testStatsViewModelATK(){
        let statsViewModel = StatsViewModel(stats: Stats(baseStat: 49, effort: 0, stat: Stat(name: "attack", url: "https://pokeapi.co/api/v2/stat/2/")))
        
        XCTAssertEqual(statsViewModel.name, "Attack")
        XCTAssertEqual(statsViewModel.value, 49)
        XCTAssertEqual(statsViewModel.progressValue, 49/181) // Gen VIII Dex max ATK = 181
    }
    
    func testStatsViewModelDEF(){
        let statsViewModel = StatsViewModel(stats: Stats(baseStat: 49, effort: 0, stat: Stat(name: "defense", url: "https://pokeapi.co/api/v2/stat/3/")))
        
        XCTAssertEqual(statsViewModel.name, "Defense")
        XCTAssertEqual(statsViewModel.value, 49)
        XCTAssertEqual(statsViewModel.progressValue, 49/230) // Gen VIII Dex max DEF = 230
    }
    
    func testStatsViewModelSPATK(){
        let statsViewModel = StatsViewModel(stats: Stats(baseStat: 65, effort: 0, stat: Stat(name: "special-attack", url: "https://pokeapi.co/api/v2/stat/4/")))
        
        XCTAssertEqual(statsViewModel.name, "Sp. ATK")
        XCTAssertEqual(statsViewModel.value, 65)
        XCTAssertEqual(statsViewModel.progressValue, 65/173) // Gen VIII Dex max SP.ATK = 173
    }
    
    func testStatsViewModelSPDEF(){
        let statsViewModel = StatsViewModel(stats: Stats(baseStat: 65, effort: 0, stat: Stat(name: "special-defense", url: "https://pokeapi.co/api/v2/stat/5/")))
        
        XCTAssertEqual(statsViewModel.name, "Sp. DEF")
        XCTAssertEqual(statsViewModel.value, 65)
        XCTAssertEqual(statsViewModel.progressValue, 65/230) // Gen VIII Dex max SP.DEF = 230
    }
    
    func testStatsViewModelSPD(){
        let statsViewModel = StatsViewModel(stats: Stats(baseStat: 45, effort: 0, stat: Stat(name: "speed", url: "https://pokeapi.co/api/v2/stat/6/")))
        
        XCTAssertEqual(statsViewModel.name, "Speed")
        XCTAssertEqual(statsViewModel.value, 45)
        XCTAssertEqual(statsViewModel.progressValue, 45/200) // Gen VIII Dex max SPD = 200
    }

    func testImageViewerViewModel(){
        let imageViewerViewModel = ImageViewerViewModel(pokemonModel: PokeappTests.pokemonModel)
        
        XCTAssertEqual(
            imageViewerViewModel.imageURLs,
            [
                URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"),
                URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
                URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png"),
                URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"),
                URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png"),
            ]
        )
    }
}
