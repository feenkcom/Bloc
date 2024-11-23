"
#Styles
Represents a set of {{gtClass:BlAbstractStyle}} and is responsible for properly adding, removing and matching styles.
{{gtClass:BlElementStyles}} also plays a role of a factory to define styles for most commonly used {{gtClass:BlElementState}}. 

##Element styles
A notable member of the styles hierarchy is {{gtClass:BlElementStyles}}, which, as the name suggests, belongs to an element. Compared to other types of {{gtClass:BlAbstractStyles}} it notifies its element when a new style is added or removed, which allows the graphical scene to recompute and apply new styles if they match element's state. It also knows how to apply styles that match element's state . See {{gtClass:BlElementStyles}} to learn more.

##Forwarded styles
By default, styles are applied on the same element to which that collection of styles is assigned (see {{gtClass:BlElementStyles}}). However, sometimes users may want to apply styles on a child element based on the state of its parent, therefore we should be able to forward styles to some other arbitrary element. A simple example would be a button widget, which has a text element as its child. Users may want to decide to change the text color of the text child element based on the hovered or pressed state of the parent Button element. In this case forwarded styles is the only nice declarative way to implement such behavior. See {{gtClass:BlForwardedStyles}} and {{gtClass:BlForwardedStyles}} to learn more.

"
Class {
	#name : #BlAbstractStyles,
	#superclass : #Object,
	#category : #'Bloc-Core-Style'
}
