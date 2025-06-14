"
I am responsible for applying text attributes on {{gtClass:BlText}} based on some logic, for example it can be code syntax highlighting.

I am independent from the text editor.
The main entrance point is 

"
Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #testing }
BlTextStyler >> affectsText [
	"Return true if the styler affects text in any form or shape, false otherwise"

	^ true
]

{ #category : #'gt-extension' }
BlTextStyler >> gtStylersFor: aView [
	<gtView>
	
	self stylers
		ifEmpty: [ ^ aView empty ].
	
	^ aView tree
		title: 'Stylers';
		priority: 5;
		items: [ { self } ];
		children: #stylers;
		expandAll
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'api - styling' }
BlTextStyler >> style: aBlText [
	<return: #BlText>

	^ BlTextStylerTelemetry
		rootTimeSync: [ Processor activeProcess name, '  ', self class name, ': ', (aBlText first: (20 min: aBlText size)) asString ]
		during: [
			| anUnstyledText aStyledText |
			anUnstyledText := aBlText unstyle.
			aStyledText := self privateStyle: anUnstyledText characters.
			aStyledText text ]
]

{ #category : #accessing }
BlTextStyler >> stylers [
	"In case of a composite styler, return children stylers"
	<return: #Collection of: #BlTextStyler>

	^ #()
]

{ #category : #accessing }
BlTextStyler >> theme [
	^ BlTheme default
]
