"
I contain examples for {{gtClass:BlShortcutId}} verifying creation, equality semantics (based on identifier only), display behavior, and usage as dictionary keys.
"
Class {
	#name : #BlShortcutIdExamples,
	#superclass : #Object,
	#category : 'Bloc-Tests-KeyBinding'
}

{ #category : #'examples - equality' }
BlShortcutIdExamples >> equalityIgnoresDescription [
	<gtExample>
	<return: #BlShortcutId>
	"Equality is based on identifier only, not description"
	| id1 id2 |
	id1 := BlShortcutId identifier: #Undo description: 'Undo last action'.
	id2 := BlShortcutId identifier: #Undo description: 'Different description'.
	
	self assert: id1 equals: id2.
	self assert: id1 hash equals: id2 hash.
	
	^ id1
]

{ #category : #'examples - equality' }
BlShortcutIdExamples >> equalShortcutIds [
	<gtExample>
	<return: #BlShortcutId>
	"Two shortcut ids with the same identifier are equal"
	| id1 id2 |
	id1 := BlShortcutId identifier: #Copy.
	id2 := BlShortcutId identifier: #Copy.
	
	self assert: id1 equals: id2.
	self assert: id1 hash equals: id2 hash.
	self assert: (id1 == id2) not.
	
	^ id1
]

{ #category : #'examples - display' }
BlShortcutIdExamples >> gtDisplayString [
	<gtExample>
	<return: #BlShortcutId>
	"gtDisplayString returns the identifier"
	| shortcutId |
	shortcutId := BlShortcutId identifier: #MoveUp.
	
	self assert: shortcutId gtDisplayString equals: 'MoveUp'.
	
	^ shortcutId
]

{ #category : #'examples - equality' }
BlShortcutIdExamples >> notEqualShortcutIds [
	<gtExample>
	<return: #BlShortcutId>
	"Two shortcut ids with different identifiers are not equal"
	| id1 id2 |
	id1 := BlShortcutId identifier: #Copy.
	id2 := BlShortcutId identifier: #Paste.
	
	self assert: (id1 = id2) not.
	
	^ id1
]

{ #category : #'examples - creation' }
BlShortcutIdExamples >> shortcutIdWithIdentifier [
	<gtExample>
	<return: #BlShortcutId>
	| shortcutId |
	shortcutId := BlShortcutId identifier: #MyShortcut.
	
	self assert: shortcutId identifier equals: #MyShortcut.
	self assert: shortcutId description isNil.
	
	^ shortcutId
]

{ #category : #'examples - creation' }
BlShortcutIdExamples >> shortcutIdWithIdentifierAndDescription [
	<gtExample>
	<return: #BlShortcutId>
	| shortcutId |
	shortcutId := BlShortcutId identifier: #SaveFile description: 'Save the current file'.
	
	self assert: shortcutId identifier equals: #SaveFile.
	self assert: shortcutId description equals: 'Save the current file'.
	
	^ shortcutId
]

{ #category : #'examples - dictionary usage' }
BlShortcutIdExamples >> usableAsDictionaryKey [
	<gtExample>
	<return: #Dictionary>
	"ShortcutIds can be used as dictionary keys, matching by identifier"
	| dict id1 id2 |
	dict := Dictionary new.
	id1 := BlShortcutId identifier: #TestKey.
	dict at: id1 put: 'value1'.
	
	id2 := BlShortcutId identifier: #TestKey.
	
	self assert: (dict at: id2) equals: 'value1'.
	self assert: dict size equals: 1.
	
	^ dict
]
