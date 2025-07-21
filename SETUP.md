# GitHub Pages Setup Instructions

## Repository Configuration Required

To enable the Helm chart repository to work properly, the following GitHub repository settings need to be configured:

### 1. Enable GitHub Pages

1. Go to the repository **Settings** tab
2. Scroll down to **Pages** section in the left sidebar
3. Under **Source**, select **Deploy from a branch**
4. Choose **gh-pages** branch and **/ (root)** folder
5. Click **Save**

### 2. Verify Action Permissions

1. Go to **Settings** → **Actions** → **General**
2. Under **Workflow permissions**, ensure:
   - **Read and write permissions** is selected
   - **Allow GitHub Actions to create and approve pull requests** is checked

### 3. Create Initial Release (Optional)

To trigger the first release, you can either:

**Option A: Make a change to the chart**
1. Update the chart version in `charts/chatwoot/Chart.yaml`
2. Commit and push to main branch
3. The workflow will automatically run

**Option B: Manually trigger workflow**
1. Go to **Actions** tab
2. Select "Release Charts" workflow
3. Click "Run workflow" → "Run workflow"

## Verification

After the setup is complete and the workflow has run:

1. **Check GitHub Pages deployment**: 
   - Visit `https://davides93.github.io/chatwoot-charts`
   - Should show the Helm repository page

2. **Verify index.yaml**:
   - Visit `https://davides93.github.io/chatwoot-charts/index.yaml`
   - Should show the Helm repository index

3. **Test Helm installation**:
   ```bash
   # Run the test script
   ./test-chart-repo.sh
   
   # Or manually test
   helm repo add chatwoot https://davides93.github.io/chatwoot-charts
   helm repo update
   helm search repo chatwoot
   ```

## Troubleshooting

### If GitHub Pages shows 404:
- Verify Pages is enabled and configured for gh-pages branch
- Check that the workflow has run successfully and pushed to gh-pages
- Wait a few minutes for Pages to propagate changes

### If workflow fails:
- Check Actions tab for error details
- Ensure the repository has proper permissions set
- Verify that the chart syntax is valid: `helm lint charts/chatwoot/`

### If chart installation fails:
- Verify the index.yaml is accessible
- Check that chart dependencies are properly specified
- Ensure the chart version in Chart.yaml follows semantic versioning

## Current Status

The repository is now configured with:
- ✅ Updated GitHub Action workflow using latest versions
- ✅ Proper permissions and setup for chart-releaser
- ✅ Correct repository URL in documentation
- ✅ Comprehensive README with usage examples
- ✅ GitHub Pages index.html for better user experience
- ✅ Test script for validation

**Next step**: Enable GitHub Pages in repository settings pointing to gh-pages branch.