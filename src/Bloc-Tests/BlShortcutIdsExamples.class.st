"
I contain examples for the extensible shortcut IDs mechanism in BlShortcutIds.
"
Class {
	#name : #BlShortcutIdsExamples,
	#superclass : #Object,
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #examples }
BlShortcutIdsExamples >> extraShortcutIdCachedOnSubsequentAccess [
	<gtExample>
	<return: #BlShortcutIds>
	"Verifies that shortcutIdForIdentifier: returns the same id on second access"
	| ids id1 id2 |
	ids := BlShortcutIds new.
	id1 := ids shortcutIdForIdentifier: #TestCached.
	id2 := ids shortcutIdForIdentifier: #TestCached.
	self assert: id1 == id2.
	^ ids
]

{ #category : #examples }
BlShortcutIdsExamples >> extraShortcutIdCreatedOnFirstAccess [
	<gtExample>
	<return: #BlShortcutId>
	"Verifies that shortcutIdForIdentifier: creates a new id on first access"
	| ids id |
	ids := BlShortcutIds new.
	id := ids shortcutIdForIdentifier: #TestExtra.
	self assert: id notNil.
	self assert: id class equals: BlShortcutId.
	self assert: id identifier equals: #TestExtra.
	^ id
]

{ #category : #examples }
BlShortcutIdsExamples >> extraShortcutIdsDictionaryInitialized [
	<gtExample>
	<return: #BlShortcutIds>
	"Verifies that a new BlShortcutIds instance has an empty extraShortcutIdsByIdentifier"
	| ids |
	ids := BlShortcutIds new.
	self assert: ids extraShortcutIdsByIdentifier notNil.
	self assert: ids extraShortcutIdsByIdentifier isEmpty.
	^ ids
]

{ #category : #examples }
BlShortcutIdsExamples >> subclassInheritsExtraMechanism [
	<gtExample>
	<return: #GtCoderShortcutIds>
	"Verifies that a subclass of BlShortcutIds can use extraShortcutIdsByIdentifier"
	| ids id |
	ids := GtCoderShortcutIds new.
	id := ids shortcutIdForIdentifier: #TestSubclassExtra.
	self assert: id notNil.
	self assert: id identifier equals: #TestSubclassExtra.
	self assert: (ids extraShortcutIdsByIdentifier includesKey: #TestSubclassExtra).
	^ ids
]
