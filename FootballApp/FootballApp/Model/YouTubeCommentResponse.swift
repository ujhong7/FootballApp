//
//  YouTubeCommentResponse.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import Foundation

// MARK: - YouTubeCommentResponse
struct YouTubeCommentResponse: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String?
    let pageInfo: PageInfo
    let items: [CommentThread]
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}

// MARK: - CommentThread
struct CommentThread: Codable {
    let kind: String
    let etag: String
    let id: String
    let snippet: CommentThreadSnippet
}

// MARK: - CommentThreadSnippet
struct CommentThreadSnippet: Codable {
    let channelId: String
    let videoId: String
    let topLevelComment: Comment
    let canReply: Bool
    let totalReplyCount: Int
    let isPublic: Bool
}

// MARK: - Comment
struct Comment: Codable {
    let kind: String
    let etag: String
    let id: String
    let snippet: CommentSnippet
}

// MARK: - CommentSnippet
struct CommentSnippet: Codable {
    let channelId: String
    let videoId: String
    let textDisplay: String
    let textOriginal: String
    let authorDisplayName: String
    let authorProfileImageUrl: String
    let authorChannelUrl: String
    let authorChannelId: AuthorChannelId
    let canRate: Bool
    let viewerRating: String
    let likeCount: Int
    let publishedAt: String
    let updatedAt: String
}

// MARK: - AuthorChannelId
struct AuthorChannelId: Codable {
    let value: String
}
