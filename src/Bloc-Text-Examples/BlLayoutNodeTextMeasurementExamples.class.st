Class {
	#name : #BlLayoutNodeTextMeasurementExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Measurement'
}

{ #category : #'instance creation' }
BlLayoutNodeTextMeasurementExamples >> baseline [
	<gtExample>
	<return: #BlTextParagraphAscentLooseBaseline>
	^ BlTextParagraphAscentLooseBaseline new
]

{ #category : #'instance creation' }
BlLayoutNodeTextMeasurementExamples >> boundsMeasurement [
	<gtExample>
	<return: #BlTextElementLabelMeasurementStrategy>
	^ BlTextElementLabelMeasurementStrategy new
]

{ #category : #'instance creation' }
BlLayoutNodeTextMeasurementExamples >> layoutChildNode [
	<gtExample>
	<return: #BlLayoutChildNode>
	^ BlLayoutChildNode new
		constraints: BlLayoutCommonConstraints new;
		measurement: self layoutNodeMeasurement;
		fitContent
]

{ #category : #'instance creation' }
BlLayoutNodeTextMeasurementExamples >> layoutNodeMeasurement [
	<gtExample>
	<return: #BlLayoutNodeTextMeasurement>
	^ BlLayoutNodeTextMeasurement new
		text: self text;
		baseline: self baseline;
		measurer: self mockedMeasurer;
		boundsMeasurement: self boundsMeasurement
]

{ #category : #measurement }
BlLayoutNodeTextMeasurementExamples >> measureLayoutChildNode [
	<gtExample>
	<return: #BlLayoutChildNode>
	| aLayoutNode |
	aLayoutNode := self layoutChildNode.
	aLayoutNode measure: BlExtentMeasurementSpec unspecified.

	^ aLayoutNode
]

{ #category : #'instance creation' }
BlLayoutNodeTextMeasurementExamples >> mockedMeasurer [
	<gtExample>
	<return: #BlMockedTextMeasurer>
	^ BlMockedTextMeasurer new
		ascent: -10;
		descent: 5;
		glyphWidth: 10;
		height: 15
]

{ #category : #'instance creation' }
BlLayoutNodeTextMeasurementExamples >> text [
	<gtExample>
	<return: #BlRunRopedText>
	^ 'Hello' asRopedText
]
