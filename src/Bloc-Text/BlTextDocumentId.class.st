"
I identify a version of a text document.

I am a pair of a `textId`, identifying a document lineage, and a `revisionId`, identifying a version within that lineage. I am immutable: `withIncreasedTextId` and `withIncreasedRevisionId` return new instances.

A fresh {{gtClass:BlRunRopedText}} obtains a `textId` from the class-side counter and starts at revision 1. Copying a text preserves my whole value, so a copy that is later edited advances only its own revision. This means I identify a document *version*, not an object: two texts may share a `textId` and differ only in `revisionId`.

That is what makes the styling round-trip work. The styler works on a copy, and the result is integrated only while the live text has not advanced meanwhile.

I mirror `DocumentId` in the Rust editor (`gtoolkit-editor-text/src/text.rs`), which has the same two fields and the same semantics.

See {{gtClass:GtTextEditorDocumentId}} for the FFI counterpart used by the Rust-backed editor.
"
Class {
	#name : #BlTextDocumentId,
	#superclass : #Object,
	#instVars : [
		'textId',
		'revisionId'
	],
	#classInstVars : [
		'textIdCounter',
		'textIdMutex'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #'class initialization' }
BlTextDocumentId class >> initialize [
	textIdMutex := Mutex new.
	textIdCounter := 1
]

{ #category : #accessing }
BlTextDocumentId class >> nextTextId [
	"Answer a text id that was not answered before.
	I mirror `next_text_id()` in the Rust editor: the counter starts at 1, and each call answers
	the current value before increasing it."
	<return: #Integer>

	^ self textIdMutex critical: [
		| aTextId |
		aTextId := textIdCounter ifNil: [ 1 ].
		textIdCounter := aTextId + 1.
		aTextId ]
]

{ #category : #'instance creation' }
BlTextDocumentId class >> textId: aTextId revisionId: aRevisionId [
	<return: #BlTextDocumentId>

	^ self new textId: aTextId revisionId: aRevisionId
]

{ #category : #private }
BlTextDocumentId class >> textIdMutex [
	"Answer the lock guarding the text id counter.
	Pharo has no atomic increment, unlike the Rust editor which uses a relaxed AtomicU64."
	<return: #Mutex>

	^ textIdMutex ifNil: [ textIdMutex := Mutex new ]
]

{ #category : #comparing }
BlTextDocumentId >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	self class = anObject class ifFalse: [ ^ false ].

	^ self textId = anObject textId and: [ self revisionId = anObject revisionId ]
]

{ #category : #printing }
BlTextDocumentId >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Document ';
		print: self textId;
		nextPutAll: '.';
		print: self revisionId
]

{ #category : #comparing }
BlTextDocumentId >> hash [
	^ (self class hash hashMultiply bitXor: self textId hash hashMultiply)
		bitXor: self revisionId hash hashMultiply
]

{ #category : #printing }
BlTextDocumentId >> printOn: aStream [
	aStream
		nextPutAll: 'DocumentId(id: ';
		print: self textId;
		nextPutAll: ', revision: ';
		print: self revisionId;
		nextPutAll: ')'
]

{ #category : #accessing }
BlTextDocumentId >> revisionId [
	"Answer the identifier of my version within the document lineage."
	<return: #Integer>

	^ revisionId
]

{ #category : #accessing }
BlTextDocumentId >> textId [
	"Answer the identifier of the document lineage I belong to."
	<return: #Integer>

	^ textId
]

{ #category : #initialization }
BlTextDocumentId >> textId: aTextId revisionId: aRevisionId [
	textId := aTextId.
	revisionId := aRevisionId
]

{ #category : #copying }
BlTextDocumentId >> withIncreasedRevisionId [
	<return: #BlTextDocumentId>

	^ self class textId: textId revisionId: revisionId + 1
]
