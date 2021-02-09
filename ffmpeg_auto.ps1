<#
- �����p�̘^��T�[�o�̎������k�X�N���v�g�ł��B
- �K���ȃt�H���_(����������E�h���C�u) ��TS�t�@�C����mp4(H264)�Ɉ��k���܂�
- ���O��ffmepg��path�ɒǉ����邱��
- �g����
    - .\ffmpeg_auto.ps1 <ts�t�@�C�����u���Ă���t�@�I���_��:��:"e:\"
#>

# �����
## �J�����g�f�B���N�g���̏����擾����
$str_path = (Convert-Path .)
## �t�@�C�����p�Ɏ��Ԃ��擾����
$date = Get-Date -Format yyMMdd_HHmm
## log�t�@�C���̕ۑ���
$log_file = "$($str_path)\logs\$($date)_result.log"
## �Ώۃf�B���N�g���̑I��
$target_dlr = $args[0]

# ��ƊJ�n
## message
$msg = "[info], $($date) ���掩�����k�X�N���v�g�����s���܂�" |Out-File -FilePath $log_file -Append -Encoding default


# �Ώۃf�B���N�g���̃t�@�C�����擾����
$file = Get-ChildItem "$($target_dlr)\*.*" -include *.ts

foreach($file_check in $file){
    $st_msg = "[info], $($date) $($file_check.name)��mp4�ɕϊ����܂�" |Out-File -FilePath $log_file -Append -Encoding default

    # ffmmpeg�̎��s
    ffmpeg -i "$($target_dlr)\$($file_check.name)" -c:v libx265 "$($target_dlr)\$file_check.name).mp4"

    # �o�̓��b�Z
    $end_msg = "[info, $($date) $($file_check.name)��mp4�ɕϊ����܂���" |Out-File -FilePath $log_file -Append -Encoding default
}