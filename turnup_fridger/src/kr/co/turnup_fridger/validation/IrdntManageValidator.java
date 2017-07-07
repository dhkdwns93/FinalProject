package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.IrdntManage;

public class IrdntManageValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(IrdntManage.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		IrdntManage irdnt = (IrdntManage) target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntId", "required.irdntManage.irdntId");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntName", "required.irdntManage.irdntName");


		if(irdnt.getRoomTemPeriod()==0 && (irdnt.getRoomTemPeriod()<0 || irdnt.getRoomTemPeriod()>1001)){
			errors.rejectValue("RoomTemPeriod", "required.irdntManage.RoomTemPeriod");
		}
		if(irdnt.getColdTemPeriod()<0||irdnt.getColdTemPeriod()>1001){
			errors.rejectValue("ColdTemPeriod", "required.irdntManage.ColdTemPeriod");
		}
		if(irdnt.getFreezeTemPeriod()<0||irdnt.getFreezeTemPeriod()>1001){
			errors.rejectValue("FreezeTemPeriod", "required.irdntManage.FreezeTemPeriod");
		}
		
	}

}
