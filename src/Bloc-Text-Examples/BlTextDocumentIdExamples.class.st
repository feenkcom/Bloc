"
I exemplify {{gtClass:BlTextDocumentId}} — how a document id is built, compared, increased, and how fresh text ids are handed out.
"
Class {
	#name : #BlTextDocumentIdExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> addingAttributesKeepsTheDocumentId [
	"Only content changes advance the revision, exactly as in the Rust editor."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello world' asRopedText.
	aDocumentId := aText documentId.

	(aText from: 1 to: 5) bold.

	self assert: aText documentId equals: aDocumentId.

	^ aText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> appendingATextBumpsTheRevisionId [
	"#insertText:at: is a mutation path of its own, it does not go through #insertStrings:atAll:."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.

	aText , ' world' asRopedText.

	self assert: aText asString equals: 'Hello world'.
	self assert: aText documentId textId equals: aDocumentId textId.
	self assert: aText documentId revisionId equals: aDocumentId revisionId + 1.

	^ aText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> appendingAnEmptyTextKeepsTheDocumentId [
	"Appending an empty text announces nothing, so it must not advance the revision either."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.

	aText , '' asRopedText.

	self assert: aText asString equals: 'Hello'.
	self assert: aText documentId equals: aDocumentId.

	^ aText
]

{ #category : #'examples - text' }
BlTextDocumentIdExamples >> copiedTextKeepsDocumentId [
	"Copying preserves the whole document id, like `derive(Clone)` on the Rust `Text`.
	This is what lets a styled copy be matched back to the text it came from."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aCopy |
	aText := 'Hello world' asRopedText.
	aCopy := aText copy.

	self assert: aCopy documentId equals: aText documentId.

	^ aCopy
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> deletingBumpsTheRevisionId [
	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello world' asRopedText.
	aDocumentId := aText documentId.

	aText delete: 6 to: 11.

	self assert: aText asString equals: 'Hello'.
	self assert: aText documentId textId equals: aDocumentId textId.
	self assert: aText documentId revisionId equals: aDocumentId revisionId + 1.

	^ aText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> deletingNothingKeepsTheDocumentId [
	"Mirrors `delete_mut` in the Rust editor, which returns before bumping when the range is
	empty."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.

	aText delete: 1 to: 0.

	self assert: aText asString equals: 'Hello'.
	self assert: aText documentId equals: aDocumentId.

	^ aText
]

{ #category : #examples }
BlTextDocumentIdExamples >> differentDocumentIds [
	"Document ids differing in either component are not equal."

	<gtExample>
	<return: #BlTextDocumentId>
	| aDocumentId |
	aDocumentId := self documentId.

	self
		assert: aDocumentId = (BlTextDocumentId textId: 7 revisionId: 4)
		equals: false.
	self
		assert: aDocumentId = (BlTextDocumentId textId: 8 revisionId: 3)
		equals: false.
	self assert: aDocumentId = nil equals: false.

	^ aDocumentId
]

{ #category : #examples }
BlTextDocumentIdExamples >> documentId [
	<gtExample>
	<return: #BlTextDocumentId>
	| aDocumentId |
	aDocumentId := BlTextDocumentId textId: 7 revisionId: 3.

	self assert: aDocumentId textId equals: 7.
	self assert: aDocumentId revisionId equals: 3.

	^ aDocumentId
]

{ #category : #examples }
BlTextDocumentIdExamples >> documentIdWithIncreasedRevisionId [
	"Increasing the revision id keeps the text id and leaves the receiver untouched."

	<gtExample>
	<return: #BlTextDocumentId>
	| aDocumentId aNextDocumentId |
	aDocumentId := self documentId.
	aNextDocumentId := aDocumentId withIncreasedRevisionId.

	self assert: aNextDocumentId textId equals: aDocumentId textId.
	self assert: aNextDocumentId revisionId equals: aDocumentId revisionId + 1.
	self assert: aDocumentId revisionId equals: 3.

	^ aNextDocumentId
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> editingACopyLeavesTheOriginalDocumentIdUntouched [
	"Editing a copy advances only the copy's revision, exactly as in the Rust editor where a
	`Text` is an owned value and `insert_str_mut` takes `&mut self`.
	The two texts then share a text id and differ only in revision: a document id names a
	version, not an object."

	<gtExample>
	<return: #Array>
	| aText aCopy aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.
	aCopy := aText copy.

	aCopy insertString: ' world' at: aCopy size.

	self assert: aText asString equals: 'Hello'.
	self assert: aCopy asString equals: 'Hello world'.

	self assert: aText documentId equals: aDocumentId.
	self assert: aCopy documentId textId equals: aDocumentId textId.
	self assert: aCopy documentId revisionId equals: aDocumentId revisionId + 1.

	^ {aText. aCopy}
]

{ #category : #'examples - text' }
BlTextDocumentIdExamples >> emptyTextHasNoDocumentId [
	"BlEmptyText is a shared instance standing for no text at all, so it holds no document.
	It is the only BlText subclass answering nil: BlText itself declares #documentId as a
	subclass responsibility."

	<gtExample>
	<return: #BlEmptyText>
	| aText |
	aText := BlEmptyText uniqueInstance.

	self assert: aText documentId isNil.

	^ aText
]

{ #category : #examples }
BlTextDocumentIdExamples >> equalDocumentIds [
	"Two document ids with the same text id and revision id are equal and hash alike."

	<gtExample>
	<return: #BlTextDocumentId>
	| aDocumentId anotherDocumentId |
	aDocumentId := self documentId.
	anotherDocumentId := BlTextDocumentId textId: 7 revisionId: 3.

	self assert: aDocumentId equals: anotherDocumentId.
	self assert: aDocumentId hash equals: anotherDocumentId hash.

	^ aDocumentId
]

{ #category : #'examples - text' }
BlTextDocumentIdExamples >> freshTextsHaveDifferentDocumentIds [
	"Every new text is a new document, like `Text::from_str` in the Rust editor."

	<gtExample>
	<return: #Array>
	| aText anotherText |
	aText := 'Hello world' asRopedText.
	anotherText := 'Hello world' asRopedText.

	self assert: aText documentId revisionId equals: 1.
	self assert: anotherText documentId revisionId equals: 1.
	self assert: aText documentId = anotherText documentId equals: false.

	^ {aText. anotherText}
]

{ #category : #'examples - text' }
BlTextDocumentIdExamples >> generationTextReportsDocumentIdOfItsText [
	"A next generation wraps a copy of the text, and a copy keeps the document id.
	This is what makes a styled generation matchable against the text it came from."

	<gtExample>
	<return: #BlGenerationText>
	| aText aGenerationText |
	aText := 'Hello world' asRopedText.
	aGenerationText := aText nextGeneration.

	self assert: aGenerationText documentId equals: aText documentId.

	^ aGenerationText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> insertingAStringBumpsTheRevisionId [
	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.

	aText insertString: ' world' at: aText size.

	self assert: aText asString equals: 'Hello world'.
	self assert: aText documentId textId equals: aDocumentId textId.
	self assert: aText documentId revisionId equals: aDocumentId revisionId + 1.

	^ aText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> insertingAnEmptyStringKeepsTheDocumentId [
	"Mirrors `insert_str_mut` in the Rust editor, which returns before bumping when the string
	is empty."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.

	aText insertString: '' at: 0.

	self assert: aText documentId equals: aDocumentId.

	^ aText
]

{ #category : #examples }
BlTextDocumentIdExamples >> nextTextIdsAreDistinctAcrossProcesses [
	"Text ids requested from several processes at once are all distinct.
	Pharo has no atomic increment, so the counter is guarded by a Mutex."

	<gtExample>
	<return: #OrderedCollection>
	| aProcessCount anIdCount allTextIds aLock aDone |
	aProcessCount := 4.
	anIdCount := 50.
	allTextIds := OrderedCollection new.
	aLock := Mutex new.
	aDone := Semaphore new.

	aProcessCount
		timesRepeat: [ [ | theTextIds |
			theTextIds := (1 to: anIdCount) collect: [ :each | BlTextDocumentId nextTextId ].
			aLock critical: [ allTextIds addAll: theTextIds ].
			aDone signal ] forkAt: Processor userBackgroundPriority ].

	aProcessCount
		timesRepeat: [ self assert: (aDone waitTimeoutSeconds: 10) equals: false ].

	self assert: allTextIds size equals: aProcessCount * anIdCount.
	self assert: allTextIds asSet size equals: aProcessCount * anIdCount.

	^ allTextIds
]

{ #category : #examples }
BlTextDocumentIdExamples >> nextTextIdsIncrease [
	"Successive text ids differ and increase."

	<gtExample>
	<return: #Array>
	| aTextId anotherTextId |
	aTextId := BlTextDocumentId nextTextId.
	anotherTextId := BlTextDocumentId nextTextId.

	self assert: anotherTextId > aTextId.

	^ {aTextId. anotherTextId}
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> removingAttributesKeepsTheDocumentId [
	"Only content changes advance the revision, exactly as in the Rust editor."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := self addingAttributesKeepsTheDocumentId.
	aDocumentId := aText documentId.

	aText clearAttributes: 1 to: 5.

	self assert: aText documentId equals: aDocumentId.

	^ aText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> revisionIsAlreadyBumpedWhenDeletionIsAnnounced [
	"See #revisionIsAlreadyBumpedWhenInsertionIsAnnounced."

	<gtExample>
	<return: #BlTextDocumentId>
	| aText aDocumentId anAnnouncedDocumentId |
	aText := 'Hello world' asRopedText.
	aDocumentId := aText documentId.
	anAnnouncedDocumentId := nil.

	aText
		when: BlTextsDeleted
		do: [ :anAnnouncement | anAnnouncedDocumentId := aText documentId ]
		for: self.

	aText delete: 6 to: 11.

	self assert: anAnnouncedDocumentId equals: aText documentId.
	self assert: anAnnouncedDocumentId revisionId equals: aDocumentId revisionId + 1.

	^ anAnnouncedDocumentId
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> revisionIsAlreadyBumpedWhenInsertionIsAnnounced [
	"The revision advances before the announcement, so every listener already sees the
	post-mutation document id. This is what will keep the editor events carrying the new revision
	once BrTextEditorModel reads its document id through to the text."

	<gtExample>
	<return: #BlTextDocumentId>
	| aText aDocumentId anAnnouncedDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.
	anAnnouncedDocumentId := nil.

	aText
		when: BlTextStringsInserted
		do: [ :anAnnouncement | anAnnouncedDocumentId := aText documentId ]
		for: self.

	aText insertString: ' world' at: aText size.

	self assert: anAnnouncedDocumentId equals: aText documentId.
	self assert: anAnnouncedDocumentId revisionId equals: aDocumentId revisionId + 1.

	^ anAnnouncedDocumentId
]

{ #category : #'examples - text' }
BlTextDocumentIdExamples >> subTextReportsDocumentIdOfItsText [
	"A sub text points at the original text, so it reports the original document id."

	<gtExample>
	<return: #BlSubText>
	| aText aSubText |
	aText := 'Hello world' asRopedText.
	aSubText := aText from: 1 to: 5.

	self assert: aSubText documentId equals: aText documentId.

	^ aSubText
]

{ #category : #'examples - text' }
BlTextDocumentIdExamples >> textCopiedFromRangeIsANewDocument [
	"Extracting a range answers an independent text, so it is a document of its own."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aPart |
	aText := 'Hello world' asRopedText.
	aPart := aText copyFrom: 1 to: 5.

	self assert: aPart asString equals: 'Hello'.
	self assert: aPart documentId = aText documentId equals: false.

	^ aPart
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> textIdSurvivesMutations [
	"A text keeps its text id for its whole life; only the revision moves."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aDocumentId |
	aText := 'Hello' asRopedText.
	aDocumentId := aText documentId.

	aText insertString: ' world' at: aText size.
	aText delete: 6 to: 11.

	self assert: aText asString equals: 'Hello'.
	self assert: aText documentId textId equals: aDocumentId textId.
	self assert: aText documentId revisionId equals: aDocumentId revisionId + 2.

	^ aText
]

{ #category : #'examples - revision' }
BlTextDocumentIdExamples >> updatingFromAStyledTextKeepsTheDocumentId [
	"Integrating a styled generation is not a content change, so the document id must survive it.
	Otherwise a styled text could never be matched against the text it came from — this is the
	counterpart of `Editor::set_styled_text` in the Rust editor."

	<gtExample>
	<return: #BlRunRopedText>
	| aText aStyledText aDocumentId |
	aText := 'Hello world' asRopedText.
	aDocumentId := aText documentId.

	aStyledText := aText nextGeneration.
	(aStyledText text from: 1 to: 5) bold.

	self assert: (aStyledText isNextGenerationOf: aText).

	aText updateFrom: aStyledText text.

	self assert: aText documentId equals: aDocumentId.

	^ aText
]
