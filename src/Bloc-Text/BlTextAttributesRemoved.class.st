"
Sent when one or more attributes are removed within an interval

"
Class {
	#name : #BlTextAttributesRemoved,
	#superclass : #Announcement,
	#instVars : [
		'fromIndex',
		'toIndex',
		'affectedText'
	],
	#category : #'Bloc-Text-Text-Events'
}

{ #category : #accessing }
BlTextAttributesRemoved >> affectedText [
	^ affectedText
]

{ #category : #accessing }
BlTextAttributesRemoved >> affectedText: anObject [
	affectedText := anObject
]

{ #category : #accessing }
BlTextAttributesRemoved >> fromIndex [
	^ fromIndex
]

{ #category : #accessing }
BlTextAttributesRemoved >> fromIndex: anObject [
	fromIndex := anObject
]

{ #category : #accessing }
BlTextAttributesRemoved >> toIndex [
	^ toIndex
]

{ #category : #accessing }
BlTextAttributesRemoved >> toIndex: anObject [
	toIndex := anObject
]
