# TRGithub
마인크래프트 플러그인 TriggerReactor의 패키지 관리 툴
</br>
## 🚨주의🚨
이것은 프로토타입 버전이며 다소 불안정할 수 있습니다.
</br></br>
# how to use?
패키지 사용법에 대해서 서술합니다.
## 명령어
> `/github`</br></br>
명령어의 종류와 기능에 대해 설명 합니다.
</br>

> `/github active <packageName>`</br>
→ 패키지를 활성화, 또는 비활성화 합니다.</br></br>
`/github active <packageName> <overwrite | skip>`</br>
→ 중복된 파일을 어떻게 처리할지 미리 설정합니다.</br></br>
※ `/github active <packageName>` 를 사용해도, 중복된 파일이 있다면, 선택지가 표시됩니다.</br>
※ 비활성화 될때 패키지에 등록된 파일명의 파일은 모두 없어집니다.
</br>

> `/github package <packageName | *>`</br>
→ 패키지의 상세 정보를 확인합니다.</br></br>
※ `*` 를 입력하면 모든 패키지의 상태가 나옵니다.
</br>

> `/github install <github repository url>`</br>
→ Url 의 Github Reposyitory에서 가장 최신인 태그 소스를 다운합니다.</br></br>
`/github install <github repository url> <version>`</br>
→ 위의 방법으로 버전을 선택 할 수도 있습니다.</br></br>
`/github install <packageName>`</br>
`/github install <packageName> <version>`</br>
→ 위 방법으로 패키지를 업데이트 할 수 있습니다.</br></br>
※ 패키지 활성화 상태 기본값 : Disable</br>
</br>

> `/github delete <packageName>`</br>
→ 패키지를 영구적으로 삭제합니다.</br></br>
※ 패키지에 등록된 파일명의 파일은 모두 없어집니다.
</br>
</br>

<blockquote><code>/github export</code></br>
  → 패키지를 자동으로 만들어줍니다.(현재 구현 안됨.)</br></br>
  <details>
  <summary>TRGithub로 패키지 구성하는 방법.</summary>
  </br>
    <blockquote>
      반갑습니다! TRGithub로 패키지를 만들고 싶으시군요?!</br></br>
      TRGithub로 패키지를 만드는 가이드를 해드리겠습니다.</br>
      <h2>패키지 구성</h2>
      </br>패키지의 구성은 다음과 같습니다.</br></br>
      <code>package-info.json</code> 파일과,
      여러분이 만든 TriggerReactor 파일만 있으면 됩니다!</br></br>
      <code>package-info.json</code>의 구성은 다음과 같습니다.</br>
      <pre>
  {
    "info": {
      "name": "패키지명",
      "author" : "제작자",
      "description": "패키지 설명",
      "jdk" : "권장 자바버전",
      "mc_version" : "테스트된 마인크래프트 버전",
      "trg_version" : "테스트된 트리거 버전"
    },
    "triggers": {
      "CommandTrigger": [
        "트리거파일.trg",
        "트리거파일.json"
      ]
    }
  }
      </pre>
      위 코드는, 당신의 Repository 안의 CommandTrigger 디렉토리 안에 있는 <code>트리거파일.trg</code> 와 <code>트리거파일.json</code> 을 감지하고,</br>
      <code>./plugin/TriggerReactor/CommandTrigger</code>에 추가 하는 역할 을 해 줄 것입니다.</br></br>
      현재 TRGithub에서 지원하는 트리거는 다음과 같습니다.</br>
      <code>"CommandTrigger", "CustomTrigger", "Executor", "InventoryTrigger", "NamedTriggers", "Placeholder", "RepeatTrigger", "Other"</code></br></br>
      <code>"Other"</code>는 추가적으로 필요한 파일이 있을때, <code>./plugin/TriggerReactor/Other</code> 디렉토리에 추가해 줄 것입니다.</br>
      그러니 그게 맞게 코드를 짜는것도 중요하다고 할 수 있습니다.</br></br>
      <h2>릴리즈 생성</h2>
      모든 파일을 깃허브에 업로드 하였다면. 이제 릴리즈를 만들 차례입니다.</br></br>
      릴리즈탭에 들어간 다음 <code>Draft new Release</code> 를 클릭하고, 태그를 생성한 다음, (태그명이 패키지 버전이 됩니다.)</br>
      타이틀도 적어주고, <code>Publish Release</code>를 클릭합니다.</br></br>
      아직도 이해가 안된다면</br>
      여기 완벽한 예제가 있습니다!</br></br>
      <a href="https://github.com/Cupelt/TRG_linearRegression">Example Package</a></br></br>
      <code>./github install github.com/Cupelt/TRG_linearRegression</code> 으로 다운로드 할 수 있으며,</br>
      <code>./github active TRG_linearRegression</code> 으로 패키지를 활성화 시킨 다음</br>
      <code>./linear_regression</code> 으로 패키지를 사용할 수 있습니다.
    </blockquote>
  </details>
</blockquote>

## 사용 예제
https://github.com/Cupelt/TRG_linearRegression 를 다운 받아서 사용 해 보겠습니다.</br></br>
1. <code>./github install github.com/Cupelt/TRG_linearRegression</code> 으로 다운로드 합니다.</br>
2. <code>./github active TRG_linearRegression</code> 으로 패키지를 활성화 시킨 다음.</br>
3. <code>./linear_regression</code> 으로 패키지를 사용할 수 있습니다.</br></br>
4. 이제 패키지가 필요 없다면 <code>./github delete TRG_linearRegression</code> 으로 패키지를 삭제 할 수 있습니다.</br></br>
4. 해당 레포지토리에 새로운 릴리즈가 생긴다면 <code>./github install TRG_linearRegression</code> 으로 패키지를 업데이트 할 수 있습니다.
