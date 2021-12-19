//
//  notificationsModel.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/18/21.
//

import Foundation

struct notificationsModel {
    
    let id: String
    let body: String
    let hour: Int
    let day: Int
}

let quotes = [
    notificationsModel(id: UUID().uuidString, body: "\"Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor.\" - Thich Nhat Hanh", hour: 12, day: 1),
    notificationsModel(id: UUID().uuidString, body: "\"The future is always beginning now.\" - Mark Strand", hour: 12, day: 2),
    notificationsModel(id: UUID().uuidString, body: "\"Each morning we are born again. What we do today is what matters most.\" - Buddha", hour: 12, day: 3),
    notificationsModel(id: UUID().uuidString, body: "\"Your vision will become clear only when you can look into your own heart. Who looks outside, dreams; who looks inside, awakes.\" - Carl Jung", hour: 12, day: 4),
    notificationsModel(id: UUID().uuidString, body: "\"Give your attention to the experience of seeing rather than to the object seen and you will find yourself everywhere.\" - Rupert Spira", hour: 12, day: 5),
    notificationsModel(id: UUID().uuidString, body: "\"In today's rush, we all think too much--seek too much--want too much--and forget about the joy of just being.\" - Eckhart Tolle", hour: 12, day: 6),
    notificationsModel(id: UUID().uuidString, body: "\"Mindfulness is the aware, balanced acceptance of the present experience. It isn’t more complicated than that. It is opening to or receiving the present moment, pleasant or unpleasant, just as it is, without either clinging to it or rejecting it.\" - Sylvia Boorstein", hour: 12, day: 7),
    notificationsModel(id: UUID().uuidString, body: "\"If you want to conquer the anxiety of life, live in the moment, live in the breath.\" - Amit Ray", hour: 12, day: 8),
    notificationsModel(id: UUID().uuidString, body: "\"We use mindfulness to observe the way we cling to pleasant experiences & push away unpleasant ones.\" - Sharon Salzberg", hour: 12, day: 9),
    notificationsModel(id: UUID().uuidString, body: "\"Awareness is the greatest agent for change.\" - Eckhart Tolle", hour: 12, day: 10),
    notificationsModel(id: UUID().uuidString, body: "\"The most precious gift we can offer others is our presence. When mindfulness embraces those we love, they will bloom like flowers.\" - Thich Nhat Hanh", hour: 12, day: 11),
    notificationsModel(id: UUID().uuidString, body: "\"We might begin by scanning our body . . . and then asking, \"What is happening?\" We might also ask, \"What wants my attention right now?\" or, \"What is asking for acceptance?\" - Tara Brach", hour: 12, day: 12),
    notificationsModel(id: UUID().uuidString, body: "\"Drink your tea slowly and reverently, as if it is the axis on which the world earth revolves – slowly, evenly, without rushing toward the future; live the actual moment. Only this moment is life.\" - Thich Nhat Hanh", hour: 12, day: 13),
    notificationsModel(id: UUID().uuidString, body: "\"I’m here to tell you that the path to peace is right there, when you want to get away.\" - Pema Chödrön", hour: 12, day: 14),
]
