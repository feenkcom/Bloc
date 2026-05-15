Class {
	#name : #BlSteppedLayoutStateAnalyzer,
	#superclass : #Object,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutStateAnalyzer >> layoutState: aSteppedLayoutState [
	"Record a new layout state.
	This method is called after every layout measure in `BlSteppedLayout>>#measure:`."

	self subclassResponsibility
]
