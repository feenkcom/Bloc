"
I am a special case of transparent background.
It is recommended to refer my unique instance since I am stateless and my superclass is immutable

"
Class {
	#name : #BlTransparentBackground,
	#superclass : #BlBackground,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Core-Background'
}

{ #category : #cleanup }
BlTransparentBackground class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlTransparentBackground class >> uniqueInstance [
	"Return a unique instance of transparent backgrond.
	It is preferable to use unique instance than create a new every time"
	<return: #BlBackground>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
BlTransparentBackground >> isTransparent [
	"I am transparent by definition"
	<return: #Boolean>
	
	^ true
]

{ #category : #geometry }
BlTransparentBackground >> matchExtent: anExtent [
	"Do nothing for the transparent background"
]
