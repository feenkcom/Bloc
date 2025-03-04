Class {
	#name : #BlSteppedLayoutLastStateAnalyzer,
	#superclass : #Object,
	#instVars : [
		'layoutState',
		'menuContainer'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutLastStateAnalyzer >> layoutState [
	^ layoutState
]

{ #category : #accessing }
BlSteppedLayoutLastStateAnalyzer >> layoutState: aSteppedLayoutState [
	layoutState := aSteppedLayoutState
]

{ #category : #accessing }
BlSteppedLayoutLastStateAnalyzer >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BlSteppedLayoutLastStateAnalyzer >> menuContainer: anObject [
	menuContainer := anObject
]
