//
//  StoriesStore.swift
//  TravelSchedule
//
//  Created by Vladimir on 08.08.2025.
//

import Foundation

final class StoriesStore {
    
    static let shared = StoriesStore()
    
    @Published private(set) var stories: [Story] = []
    @Published private(set) var authors: [StoryAuthor] = []
    
    private init() {
        authors = [StoryAuthor(id: UUID()), StoryAuthor(id: UUID()), StoryAuthor(id: UUID()), StoryAuthor(id: UUID())]
        stories = [
            Story(id: UUID(),
                  authorID: authors[0].id,
                  content: StoryPageContent(title: "Title 1", text: "Text 1", imageName: "Story1"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[0].id,
                  content: StoryPageContent(title: "Title 2", text: "Text 2", imageName: "Story2"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[0].id,
                  content: StoryPageContent(title: "Title 3", text: "Text 3", imageName: "Story3"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[1].id,
                  content: StoryPageContent(title: "Title 4", text: "Text 4", imageName: "Story4"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[1].id,
                  content: StoryPageContent(title: "Title 5", text: "Text 5", imageName: "Story5"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[1].id,
                  content: StoryPageContent(title: "Title 6", text: "Text 6", imageName: "Story1"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[2].id,
                  content: StoryPageContent(title: "Title 7", text: "Text 7", imageName: "Story2"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[2].id,
                  content: StoryPageContent(title: "Title 8", text: "Text 8", imageName: "Story3"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[2].id,
                  content: StoryPageContent(title: "Title 9", text: "Text 9", imageName: "Story4"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[3].id,
                  content: StoryPageContent(title: "Title 10", text: "Text 10", imageName: "Story5"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[3].id,
                  content: StoryPageContent(title: "Title 11", text: "Text 11", imageName: "Story1"),
                  watched: false),
            Story(id: UUID(),
                  authorID: authors[3].id,
                  content: StoryPageContent(title: "Title 12", text: "Text 12", imageName: "Story2"),
                  watched: false),
        ]
        sort()
    }
    
    func watch(story: Story) -> Bool {
        guard let index = stories.firstIndex(where: { $0.id == story.id} ) else {
            return false
        }
        stories[index] = Story(id: story.id, authorID: story.authorID, content: story.content, watched: true)
        return true
    }
    
    func hasNewContent(_ author: StoryAuthor) -> Bool {
        stories.filter { $0.authorID == author.id}.contains(where: { !$0.watched })
    }
    
    func sort() {
        authors.sort(by: { $0.id < $1.id })
        let authorsWithNewContent = authors.filter({ hasNewContent($0) })
        let watchedAuthors = authors.filter({ !hasNewContent($0) })
        authors = authorsWithNewContent + watchedAuthors
        stories.sort(by: { $0.id < $1.id} )
        var sortedStories: [Story] = []
        for author in authors {
            sortedStories.append(contentsOf: stories.filter( {$0.authorID == author.id }))
        }
        stories = sortedStories
    }
    
    private func author(with id: StoryAuthor.ID) -> StoryAuthor? {
        authors.first(where: { $0.id == id})
    }
    
}
