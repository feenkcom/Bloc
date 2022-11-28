Class {
	#name : #BlDevScripterWithAllChildrenBreadthFirstEventTarget,
	#superclass : #BlScripterElementTarget,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterWithAllChildrenBreadthFirstEventTarget >> findTargetIn: anElement [
	<return: #Collection of: #BlElement>

	^ anElement withAllChildrenBreadthFirst
]

{ #category : #printing }
BlDevScripterWithAllChildrenBreadthFirstEventTarget >> printOn: aStream [
	aStream 
		nextPutAll: 'withAllChildrenBreadthFirst'
]
