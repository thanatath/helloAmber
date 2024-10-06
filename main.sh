#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.3.5-alpha
# date: 2024-10-06 20:16:27
file_exist__1_v0() {
    local path=$1
    [ -f "${path}" ];
    __AS=$?;
if [ $__AS != 0 ]; then
        __AF_file_exist1_v0=0;
        return 0
fi
    __AF_file_exist1_v0=1;
    return 0
}
file_read__2_v0() {
    local path=$1
    __AMBER_VAL_0=$(< "${path}");
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_file_read2_v0=''
return $__AS
fi;
    __AF_file_read2_v0="${__AMBER_VAL_0}";
    return 0
}
file_write__3_v0() {
    local path=$1
    local content=$2
    __AMBER_VAL_1=$(echo "${content}" > "${path}");
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_file_write3_v0=''
return $__AS
fi;
    __AF_file_write3_v0="${__AMBER_VAL_1}";
    return 0
}
file_append__4_v0() {
    local path=$1
    local content=$2
    __AMBER_VAL_2=$(echo "${content}" >> "${path}");
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_file_append4_v0=''
return $__AS
fi;
    __AF_file_append4_v0="${__AMBER_VAL_2}";
    return 0
}
split__25_v0() {
    local text=$1
    local delimiter=$2
    __AMBER_ARRAY_0=();
    local result=("${__AMBER_ARRAY_0[@]}")
    IFS="${delimiter}" read -rd '' -a result < <(printf %s "$text");
    __AS=$?
    __AF_split25_v0=("${result[@]}");
    return 0
}
lines__26_v0() {
    local text=$1
    split__25_v0 "${text}" "
";
    __AF_split25_v0__27_12=("${__AF_split25_v0[@]}");
    __AF_lines26_v0=("${__AF_split25_v0__27_12[@]}");
    return 0
}
trim_left__29_v0() {
    local text=$1
    __AMBER_VAL_3=$(echo "${text}" | sed -e 's/^[[:space:]]*//');
    __AS=$?;
    __AF_trim_left29_v0="${__AMBER_VAL_3}";
    return 0
}
trim_right__30_v0() {
    local text=$1
    __AMBER_VAL_4=$(echo "${text}" | sed -e 's/[[:space:]]*$//');
    __AS=$?;
    __AF_trim_right30_v0="${__AMBER_VAL_4}";
    return 0
}
trim__31_v0() {
    local text=$1
    trim_right__30_v0 "${text}";
    __AF_trim_right30_v0__52_22="${__AF_trim_right30_v0}";
    trim_left__29_v0 "${__AF_trim_right30_v0__52_22}";
    __AF_trim_left29_v0__52_12="${__AF_trim_left29_v0}";
    __AF_trim31_v0="${__AF_trim_left29_v0__52_12}";
    return 0
}
len__36_v0() {
    local value=("${!1}")
            if [ 0 != 0 ]; then
            __AMBER_VAL_5=$(echo "${#value}");
            __AS=$?;
            __AF_len36_v0="${__AMBER_VAL_5}";
            return 0
else
            __AMBER_VAL_6=$(echo "${#value[@]}");
            __AS=$?;
            __AF_len36_v0="${__AMBER_VAL_6}";
            return 0
fi
}
exit__84_v0() {
    local code=$1
    exit "${code}";
    __AS=$?
}
# EXPERIMENTAL
# Compare 2 date
# Return 1 if date_a is after date_b
# Return 0 if date_a and date_b is the same
# Return -1 if date_b is after date_a
# If date_b is not provided, current date will be used
# IPv4 Logger
__0_file_name="ipv4.txt"
__1_ipv4_endpoint="https://api.ipify.org"
fetch_ipv4__109_v0() {
    __AMBER_VAL_7=$(curl ${__1_ipv4_endpoint});
    __AS=$?;
    __AF_fetch_ipv4109_v0="${__AMBER_VAL_7}";
    return 0
}
log_exist__110_v0() {
    file_exist__1_v0 "${__0_file_name}";
    __AF_file_exist1_v0__16_24="$__AF_file_exist1_v0";
    local is_log_exist="$__AF_file_exist1_v0__16_24"
    __AF_log_exist110_v0=${is_log_exist};
    return 0
}
check_same_previous_ip__111_v0() {
    local current_ip=$1
    file_read__2_v0 "${__0_file_name}";
    __AS=$?;
    __AF_file_read2_v0__21_40="${__AF_file_read2_v0}";
    lines__26_v0 "${__AF_file_read2_v0__21_40}";
    __AF_lines26_v0__21_34=("${__AF_lines26_v0[@]}");
    local logfile_content=("${__AF_lines26_v0__21_34[@]}")
    len__36_v0 logfile_content[@];
    __AF_len36_v0__22_30="$__AF_len36_v0";
    local last_line_from_log=$(echo "$__AF_len36_v0__22_30" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    split__25_v0 "${logfile_content[${last_line_from_log}]}" ":";
    __AF_split25_v0__23_23=("${__AF_split25_v0[@]}");
    local previous_ip=("${__AF_split25_v0__23_23[@]}")
    local previous_ip_text="${previous_ip[0]}"
    trim__31_v0 "${current_ip}";
    __AF_trim31_v0__25_12="${__AF_trim31_v0}";
    trim__31_v0 "${previous_ip_text}";
    __AF_trim31_v0__25_32="${__AF_trim31_v0}";
    __AF_check_same_previous_ip111_v0=$([ "_${__AF_trim31_v0__25_12}" != "_${__AF_trim31_v0__25_32}" ]; echo $?);
    return 0
}
log_content__112_v0() {
    local current_ip=$1
    __AMBER_VAL_8=$(date);
    __AS=$?;
    local log_context="${current_ip}"" : ""${__AMBER_VAL_8}"
    __AF_log_content112_v0="${log_context}";
    return 0
}
main__113_v0() {
    fetch_ipv4__109_v0 ;
    __AF_fetch_ipv4109_v0__34_22="${__AF_fetch_ipv4109_v0}";
    local current_ip="${__AF_fetch_ipv4109_v0__34_22}"
    if [ $(echo  '!' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        exit__84_v0 1;
        __AF_exit84_v0__35_34="$__AF_exit84_v0";
        echo "$__AF_exit84_v0__35_34" > /dev/null 2>&1
fi
    log_content__112_v0 "${current_ip}";
    __AF_log_content112_v0__36_23="${__AF_log_content112_v0}";
    local log_content="${__AF_log_content112_v0__36_23}"
    log_exist__110_v0 ;
    __AF_log_exist110_v0__37_12="$__AF_log_exist110_v0";
    if [ $(echo  '!' "$__AF_log_exist110_v0__37_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo "Log file does not exist. Create and logging"
        file_write__3_v0 "${__0_file_name}" "${log_content}";
        __AS=$?;
        __AF_file_write3_v0__39_16="${__AF_file_write3_v0}";
        echo "${__AF_file_write3_v0__39_16}" > /dev/null 2>&1
else
        echo "Logging IPv4"
        check_same_previous_ip__111_v0 "${current_ip}";
        __AF_check_same_previous_ip111_v0__43_16="$__AF_check_same_previous_ip111_v0";
        if [ $(echo  '!' "$__AF_check_same_previous_ip111_v0__43_16" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            echo "IP Changed "'!'""
fi
        file_append__4_v0 "${__0_file_name}" "${log_content}";
        __AS=$?;
        __AF_file_append4_v0__44_16="${__AF_file_append4_v0}";
        echo "${__AF_file_append4_v0__44_16}" > /dev/null 2>&1
fi
}
main__113_v0 ;
__AF_main113_v0__48_8="$__AF_main113_v0";
echo "$__AF_main113_v0__48_8" > /dev/null 2>&1
