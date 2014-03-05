((ng) ->
  _REGEX =
    ALPHANUMERIC : /^[a-zA-Z0-9]+$/
    ALPHANUMERIC_LOWERCASE : /^[a-z0-9]+$/

  _DIRECTIVES_NAMES =
    ALPHANUMERIC  : "angAlphaNumeric"
    PARSETONUMBER : "angParseToNumber"

  _VALIDATOR_IDENTIFIERS =
    APLHANUMERIC : "alphanumeric"

  AngValid_Helpers = ng.module('angValidateHelpers', [])

  ###
  create the directive for parsing value to number
###
  AngValid_Helpers.directive "#{_DIRECTIVES_NAMES.PARSETONUMBER}", () ->
    restrict : 'A'
    require: 'ngModel'
    link : (scope, iElem, iAttr, oController) ->
      oController.$parsers.push (value) ->
        if value is 0
          0
        else
          parseFloat value || ''
      return

  ###
  Directive to create Alphanumeric
###
  angAlphaNumericController = (scope, iElem, oAttr, oController) ->
    bOnlyAllowLowerCase = if oAttr.lowercase then scope.$eval oAttr.lowercase else off
    sRegPattern = if bOnlyAllowLowerCase is on then _REGEX.ALPHANUMERIC_LOWERCASE else _REGEX.ALPHANUMERIC

    # if it is only lowercase, the force this in here
#    oAttr.$observe 'lowercase', (bValue) ->
#      bOnlyAllowLowerCase = if bValue then on else off
#      return


    ###
  this will check the pattern for the value supplied
###
    checkPattern = (value) ->
      console.log sRegPattern

      if sRegPattern.test value
        console.log "passed: ", value
        oController.$setValidity "#{_VALIDATOR_IDENTIFIERS.APLHANUMERIC}", on
      else
        console.log "failed: ", value
        oController.$setValidity "#{_VALIDATOR_IDENTIFIERS.APLHANUMERIC}", off
      return

    oController.$parsers.push checkPattern
    return

  AngValid_Helpers.directive "#{_DIRECTIVES_NAMES.ALPHANUMERIC}", () ->
    restrict : 'A'
    require: 'ngModel'
    link : angAlphaNumericController
  return


)(angular)