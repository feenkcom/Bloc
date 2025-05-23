Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> flow [
	^ self at: BlFlowLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> frame [
	^ self at: BlFrameLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> grid [
	^ self at: BlGridLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> horizontalTreeFlow [
	^ self at: BlHorizontalTreeFlowLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> linear [
	^ self at: BlLinearLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> relative [
	^ self at: BlRelativeLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> stepped [
	^ self at: BlSteppedLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> zoomable [
	^ self at: BlZoomableLayout
]
