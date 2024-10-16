Class {
	#name : #BlTextAttributesAdded,
	#superclass : #Announcement,
	#instVars : [
		'fromIndex',
		'toIndex',
		'attributes',
		'affectedText'
	],
	#category : #'Bloc-Text-Text-Events'
}

{ #category : #accessing }
BlTextAttributesAdded >> affectedText [
	^ affectedText
]

{ #category : #accessing }
BlTextAttributesAdded >> affectedText: anObject [
	affectedText := anObject
]

{ #category : #accessing }
BlTextAttributesAdded >> attributes [
	^ attributes
]

{ #category : #'instance creation' }
BlTextAttributesAdded >> attributes: aCollectionOfAttributes [
	attributes := aCollectionOfAttributes
]

{ #category : #accessing }
BlTextAttributesAdded >> fromIndex [
	^ fromIndex
]

{ #category : #accessing }
BlTextAttributesAdded >> fromIndex: anObject [
	fromIndex := anObject
]

{ #category : #accessing }
BlTextAttributesAdded >> toIndex [
	^ toIndex
]

{ #category : #accessing }
BlTextAttributesAdded >> toIndex: anObject [
	toIndex := anObject
]
