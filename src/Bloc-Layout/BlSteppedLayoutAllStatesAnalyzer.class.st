Class {
	#name : #BlSteppedLayoutAllStatesAnalyzer,
	#superclass : #BlSteppedLayoutStateAnalyzer,
	#instVars : [
		'menuContainer',
		'layoutStates'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #initialization }
BlSteppedLayoutAllStatesAnalyzer >> initialize [
	super initialize.
	layoutStates := #()
]

{ #category : #accessing }
BlSteppedLayoutAllStatesAnalyzer >> layoutState: aSteppedLayoutState [
	layoutStates := self layoutStates copyWith: aSteppedLayoutState
]

{ #category : #accessing }
BlSteppedLayoutAllStatesAnalyzer >> layoutStates [
	^ layoutStates ifNil: [ #() ]
]

{ #category : #accessing }
BlSteppedLayoutAllStatesAnalyzer >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BlSteppedLayoutAllStatesAnalyzer >> menuContainer: anObject [
	menuContainer := anObject
]
