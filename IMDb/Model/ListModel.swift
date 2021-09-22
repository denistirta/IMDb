//
//  ListModel.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import Foundation

// MARK: - TopMovies
struct TopMovies: Codable {
    let id, rank, title, fullTitle: String?
    let year: String?
    let image: String?
    let crew, imDBRating, imDBRatingCount: String?

    enum CodingKeys: String, CodingKey {
        case id, rank, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
}

// MARK: - Detail
struct Detail: Codable {
    let id, title, originalTitle, fullTitle: String?
    let type, year: String?
    let image: String?
    let releaseDate, runtimeMins, runtimeStr, plot: String?
    let plotLocal: String?
    let plotLocalIsRTL: Bool?
    let awards, directors: String?
    let directorList: [CompanyListElement]?
    let writers: String?
    let writerList: [CompanyListElement]?
    let stars: String?
    let starList: [CompanyListElement]?
    let actorList: [Actor]?
    let fullCast: FullCast?
    let genres: String?
    let genreList: [CountryListElement]?
    let companies: String?
    let companyList: [CompanyListElement]?
    let countries: String?
    let countryList: [CountryListElement]?
    let languages: String?
    let languageList: [CountryListElement]?
    let contentRating, imDBRating, imDBRatingVotes, metacriticRating: String?
    let ratings: Ratings?
    let wikipedia: Wikipedia?
    let posters, images: Images?
    let trailer: Trailer?
    let boxOffice: BoxOffice?
    let tagline, keywords: String?
    let keywordList: [String]?
    let similars: [Similar]?
    let tvSeriesInfo, tvEpisodeInfo, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case id, title, originalTitle, fullTitle, type, year, image, releaseDate, runtimeMins, runtimeStr, plot, plotLocal
        case plotLocalIsRTL = "plotLocalIsRtl"
        case awards, directors, directorList, writers, writerList, stars, starList, actorList, fullCast, genres, genreList, companies, companyList, countries, countryList, languages, languageList, contentRating
        case imDBRating = "imDbRating"
        case imDBRatingVotes = "imDbRatingVotes"
        case metacriticRating, ratings, wikipedia, posters, images, trailer, boxOffice, tagline, keywords, keywordList, similars, tvSeriesInfo, tvEpisodeInfo, errorMessage
    }
}

// MARK: - Actor
struct Actor: Codable {
    let id: String?
    let image: String?
    let name, asCharacter: String?
}

// MARK: - BoxOffice
struct BoxOffice: Codable {
    let budget, openingWeekendUSA, grossUSA, cumulativeWorldwideGross: String?
}

// MARK: - CompanyListElement
struct CompanyListElement: Codable {
    let id, name: String?
}

// MARK: - CountryListElement
struct CountryListElement: Codable {
    let key, value: String?
}

// MARK: - FullCast
struct FullCast: Codable {
    let imDBID, title, fullTitle, type: String?
    let year: String?
    let directors, writers: Directors?
    let actors: [Actor]?
    let others: [Directors]?
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year, directors, writers, actors, others, errorMessage
    }
}

// MARK: - Directors
struct Directors: Codable {
    let job: String?
    let items: [DirectorsItem]?
}

// MARK: - DirectorsItem
struct DirectorsItem: Codable {
    let id, name, itemDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case itemDescription = "description"
    }
}

// MARK: - Images
struct Images: Codable {
    let imDBID, title, fullTitle, type: String?
    let year: String?
    let items: [ImagesItem]?
    let errorMessage: String?
    let posters, backdrops: [Backdrop]?

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year, items, errorMessage, posters, backdrops
    }
}

// MARK: - Backdrop
struct Backdrop: Codable {
    let id: String?
    let link: String?
    let aspectRatio: Double?
    let language: Language?
    let width, height: Int?
}

enum Language: String, Codable {
    case en = "en"
}

// MARK: - ImagesItem
struct ImagesItem: Codable {
    let title: String?
    let image: String?
}

// MARK: - Ratings
struct Ratings: Codable {
    let imDBID, title, fullTitle, type: String?
    let year, imDB, metacritic, theMovieDB: String?
    let rottenTomatoes, tVCOM, filmAffinity, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year
        case imDB = "imDb"
        case metacritic
        case theMovieDB = "theMovieDb"
        case rottenTomatoes
        case tVCOM = "tV_com"
        case filmAffinity, errorMessage
    }
}

// MARK: - Similar
struct Similar: Codable {
    let id, title, fullTitle, year: String?
    let image: String?
    let plot, directors, stars, genres: String?
    let imDBRating: String?

    enum CodingKeys: String, CodingKey {
        case id, title, fullTitle, year, image, plot, directors, stars, genres
        case imDBRating = "imDbRating"
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    let imDBID, title, fullTitle, type: String?
    let year, videoID, videoTitle, videoDescription: String?
    let thumbnailURL: String?
    let uploadDate: String?
    let link, linkEmbed: String?
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year
        case videoID = "videoId"
        case videoTitle, videoDescription
        case thumbnailURL = "thumbnailUrl"
        case uploadDate, link, linkEmbed, errorMessage
    }
}

// MARK: - Wikipedia
struct Wikipedia: Codable {
    let imDBID, title, fullTitle, type: String?
    let year: String?
    let language: Language?
    let titleInLanguage: String?
    let url: String?
    let plotShort, plotFull: Plot?
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year, language, titleInLanguage, url, plotShort, plotFull, errorMessage
    }
}

// MARK: - Plot
struct Plot: Codable {
    let plainText, html: String?
}
