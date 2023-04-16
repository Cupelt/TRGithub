# TRGithub
Package management tool for the Minecraft plugin TriggerReactor. <a href="https://github.com/Cupelt/TRGithub/blob/main/README_kr.md">( Korean )</a>
</br>
## 🚨Caution🚨
This is a prototype version and may be somewhat unstable
</br></br>
## How to use
This document explains how to use the package feature.

### Commands
The following commands are available:

> `/github`</br></br>
→ Displays the available commands and their functions.</br>
</br>

> `/github active <packageName>`</br>
→ Activates or deactivates the specified package.</br>
</br>

> `/github active <packageName> <overwrite|skip>`</br>
→ Sets how to handle duplicate files.</br></br>
Note: If a package contains duplicate files, the user will be prompted to choose an action even if the active command was used.</br>
</br>

> `/github package <packageName|*>`</br>
→ Displays detailed information about the specified package(s).</br>
Note: Use * to show information for all packages.</br>
</br>

> `/github install <github repository url>`</br>
→ Downloads the latest tagged source code from the specified Github repository.</br></br>
> `/github install <github repository url> <version>`</br>
→ Downloads the specified version from the Github repository.</br></br>
> `/github install <packageName>`</br>
> `/github install <packageName> <version>`</br>
→ Updates the specified package to the latest version.</br></br>
Note: The default package activation state is disabled.</br>
</br>

> `/github delete <packageName>`</br>
→ Deletes the specified package permanently.</br></br>
Note: All files with the file name that belongs to the package will be deleted.</br>
</br>
</br>

<blockquote><code>/github export</code></br>
  → Automatically creates a package (not currently implemented).</br></br>
  <details>
  <summary>How to structure a package with TRGithub</summary>
  </br>
    <blockquote>
      Hello there! You want to create a package with TRGithub?! </br></br>
      Here's a guide to help you create a package using TRGithub.</br>
      <h2>Package Structure</h2>
      </br>The package consists of the following:</br></br>
      Only the <code>package-info.json</code> file and the TriggerReactor files you create are needed!</br></br>
      The structure of <code>package-info.json</code> is as follows:</br>
      <pre>
  {
    "info": {
      "name": "Package Name",
      "author" : "Author Name",
      "description": "Package Description",
      "jdk" : "Recommended Java Version",
      "mc_version" : "Tested Minecraft Version",
      "trg_version" : "Tested TriggerReactor Version"
    },
    "triggers": {
      "CommandTrigger": [
        "triggerfile.trg",
        "triggerfile.json"
      ]
    }
  }
      </pre>
      The above code will detect <code>triggerfile.trg</code> and <code>triggerfile.json</code> in the CommandTrigger directory of your repository,</br>
      and add them to <code>./plugin/TriggerReactor/CommandTrigger</code>.</br></br>
      The triggers currently supported by TRGithub are:</br>
      <code>"CommandTrigger", "CustomTrigger", "Executor", "InventoryTrigger", "NamedTriggers", "Placeholder", "RepeatTrigger", "Other"</code></br></br>
      The <code>"Other"</code> trigger will add any additional required files to the <code>./plugin/TriggerReactor/Other</code> directory.</br>
      So, it's important to write the code correctly.</br></br>
      <h2>Creating a Release</h2>
      Once all files have been uploaded to GitHub, it's time to create a release.</br></br>
      Go to the Releases tab, click <code>Draft new Release</code>, create a tag (the tag name becomes the package version),</br>
      add a title, and click <code>Publish Release</code>.</br></br>
      If you still don't understand,</br>
      there's a perfect example here!</br></br>
      <a href="https://github.com/Cupelt/TRG_linearRegression">Example Package</a></br></br>
      You can download it using <code>./github install github.com/Cupelt/TRG_linearRegression</code>,</br>
      activate the package with <code>./github active TRG_linearRegression</code>,</br>
      and use it with <code>./linear_regression</code>.
    </blockquote>
  </details>
</blockquote>


# Usage Example
Let's download and use the package from https://github.com/Cupelt/TRG_linearRegression:</br></br>

1. Download the package by running <code>./github install github.com/Cupelt/TRG_linearRegression.</code></br>
2. Activate the package by running <code>./github active TRG_linearRegression.</code></br>
3. Now you can use the package by running <code>./linear_regression.</code></br></br>
4. If you no longer need the package, you can delete it by running <code>./github delete TRG_linearRegression.</code></br></br>
5. If a new release is available in the repository, you can update the package by running <code>./github install TRG_linearRegression.</code></br>
