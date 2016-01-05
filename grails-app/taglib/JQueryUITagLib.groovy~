package mypackage
import org.springframework.web.servlet.support.RequestContextUtils as RCU

/**
 * 
 * A datepicker based on JQuery datepicker (http://jqueryui.com/datepicker/) and (mostly) compatible with the Grails framework
 * 
 * Version 0.1 - 27/02/2014
 * 
 * Supported attributes:
 *  - name		: will be used as name and if for the actual input field
 *  - value		: default value
 *  - option	: options to pass to datepicker {key1: value1, key2: value2, ...}. See API: http://api.jqueryui.com/datepicker/
 *  - locale	: locale to be used. If not passed, it will take the grails session's locale (first two letters). jquery.datepicker's locale files should be available to your app: https://github.com/jquery/jquery-ui/tree/master/ui/i18n
 *  - class		: HTML classes to apply to the visible field
 *  - required	: HTML required attribute
 * 
 * Setup:
 *  - make sure JQuery-UI and JQuery are installed
 *  - put this class in your grails-app/tablib folder
 * 
 * Example: 
 * 	<g:datepickerUI name="myDate" required="true" value="${myDomainClass?.myDate?:new Date()}" options="{minDate:'0', maxDate:'+10Y'}" class="form-control"/>
 * 
 * 
 * Tested with:
 *  - JQuery-1.11.1
 *  - JQueryUI-1.11.3 
 *  - Grails 2.4.4
 */


//Renders the content from DB to GSP preserving newlines
class JQueryUITagLib {
	def datepickerUI = { attrs ->
		def name = attrs['name']?:'myDateField'
		def value = attrs['value']
		def options = attrs['options']?:'{}' //{key1: value1, key2: value2, ...}
		def locale = attrs['locale']?:RCU.getLocale(request).toString().substring(0,2)
		def htmlClass = attrs['class']
		def htmlRequired = attrs['required']?"required = 'true'":''
		def placeholder = attrs['placeholder']?:''
		
		def namePicker = name+"_picker";
		def nameDay = name+"_day";
		def nameMonth = name+"_month";
		def nameYear = name+"_year";
		
		def c = null
		def day;
		def month;
		def year;
		if(value!=null){
			if(value instanceof Calendar) {
				c = value
			} else {
				c = new GregorianCalendar();
				c.setTime(value)
			}
			day = c.get(GregorianCalendar.DAY_OF_MONTH)
			month = c.get(GregorianCalendar.MONTH)+1
			year = c.get(GregorianCalendar.YEAR)
		}

		out << "\
		<input type='text' id='${namePicker}' name='${namePicker}' placeholder='${placeholder}' class='${htmlClass}' ${htmlRequired} style='position: relative; z-index:100;'/>\
        \
		\
		<input type='hidden' id='${name}' name='${name}' value='date.struct' />\
		\
        <input type='hidden' id='${nameDay}' name='${nameDay}' value='${day}' />\
        <input type='hidden' id='${nameMonth}' name='${nameMonth}' value='${month}' />\
        <input type='hidden' id='${nameYear}' name='${nameYear}' value='${year}' />\
		"

		out << "\
		 <script type='text/javascript'>\
         \$(document).ready(function(){\n\
			 \$('#${namePicker}').datepicker(${options});\n\
			 \$('#${namePicker}').datepicker('option',\$.datepicker.regional['${locale}']);\n\
			 \$('#${namePicker}').on('change', function(){\n\
				 selDate = \$('#${namePicker}').datepicker('getDate');\n\
				 \$('#${nameDay}').val(selDate?selDate.getDate():null);\n\
				 \$('#${nameMonth}').val(selDate?selDate.getMonth()+1:null);\n\
				 \$('#${nameYear}').val(selDate?selDate.getFullYear():null);\n\
			 });\n\
			 var dateFormat = \$('#${namePicker}').datepicker( 'option', 'dateFormat');\n\
         "
		// If a value is specified it overrides the default date
		if(attrs['value']){
			out << "\
				 //Set date from value\n\
				 \$('#${namePicker}').datepicker('option', 'defaultDate',new Date(${year},${month-1},${day}));\n\
                 "
		}
		out << "\
			 var defaultDate = \$('#${namePicker}').datepicker( 'option', 'defaultDate');\n\
			 //Set default date\n\
		     \$('#${namePicker}').val(\$.datepicker.formatDate(dateFormat, defaultDate))\n\
	     });\n\
		 </script>\
		 \
		 "
	}
}
