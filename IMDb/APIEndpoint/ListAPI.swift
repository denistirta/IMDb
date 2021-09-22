//
//  ListAPI.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import Foundation

class ListAPI{
    private static var Top250Movies     = "Top250Movies"
    private static var Title            = "Title"
    private static var optional         = "FullActor,FullCast,Posters,Images,Trailer,Ratings,Wikipedia"
    
    static func listTop250Movies() -> String{
        return "\(BaseURL)\(Top250Movies)/\(Key)"
    }
    
    static func detailMovie(id: String) -> String{
        return "\(BaseURL)\(Title)/\(Key)/\(id)/\(optional)"
    }

}
