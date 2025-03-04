"
I am used for visual analysis of {{gtClass:BlSteppedLayout}}. 
I can be used by setting {{gtMethod:BlSteppedLayout >> analyzer:}}. Once it is set, I remember last {{gtClass:BlSteppedLayoutState}} that can be visually explored.
{{gtClass:BlScripter}} includes the following step which activates me on a given element with a dropdown: {{gtMethod: TBlDevScripterActionStep >> #prepareSteppedLayoutDropdownAnalyzer}}. 
# Example
The following example indicates where a dropdown was placed. Other available areas, that were considered during the dropdown element layout measurement, can be explored by hovering available areas buttons: {{gtExample: GtPharoCoderByScripterExamples >> #displaySecondPaneMethodSpotterDropdown | noCode=true | previewShow=#gtMenuSteppedLayoutAnalysisFor: | previewHeight=920 }}
"
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
