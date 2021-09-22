//
//  BaseUrl.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import Foundation

#if DEBUG
    var BaseURL     = "https://imdb-api.com/en/API/"
    var Key         = "k_7lb8lynv"
#else
    var BaseURL     = "https://imdb-api.com/en/API/"
    var Key         = "k_sjkev96t"
//    var Key         = "k_7lb8lynv"
#endif
